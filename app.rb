require 'rubygems'
require 'bundler'

Bundler.require
$: << File.expand_path('../', __FILE__)
$: << File.expand_path('../lib', __FILE__)

require 'sinatra'
require 'sprockets'
require 'sprockets/cache/memcache_store'
require 'stylus/sprockets'
require 'recruiter_lint'

configure do
  set :assets, assets = Sprockets::Environment.new(settings.root)

  assets.append_path('assets/javascripts')
  assets.append_path('assets/stylesheets')
  assets.append_path('assets/images')
  assets.append_path('vendor/assets/javascripts')
  assets.append_path('vendor/assets/stylesheets')

  Stylus.setup(assets)

  set :asset_host, ''
end

configure :development do
  settings.assets.cache = Sprockets::Cache::FileStore.new('./tmp')
end

configure :production do
  settings.assets.cache          = Sprockets::Cache::MemcacheStore.new
  settings.assets.js_compressor  = Closure::Compiler.new
  settings.assets.css_compressor = YUI::CssCompressor.new
end

helpers do
  def json(value)
    content_type :json
    value.to_json
  end

  def asset_path(name)
    asset = settings.assets[name]
    raise UnknownAsset, "Unknown asset: #{name}" unless asset
    "#{settings.asset_host}/assets/#{asset.digest_path}"
  end
end

get '/assets/*' do
  env['PATH_INFO'].sub!(%r{^/assets}, '')
  settings.assets.call(env)
end

get '/' do
  erb :index
end

post '/lint' do
  text = params[:text]

  if !text || text.empty?
    error 406
  end

  json RecruiterLint.run(text)
end