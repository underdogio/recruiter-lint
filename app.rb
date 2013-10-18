require 'rubygems'
require 'bundler'

Bundler.require
$: << File.expand_path('../', __FILE__)
$: << File.expand_path('../lib', __FILE__)

require 'sinatra'
require 'sprockets'
require 'sprockets/cache/memcache_store'

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
  assets.cache = Sprockets::Cache::FileStore.new('./tmp')
end

configure :production do
  assets.cache          = Sprockets::Cache::MemcacheStore.new
  assets.js_compressor  = Closure::Compiler.new
  assets.css_compressor = YUI::CssCompressor.new
end

get '/assets/*' do
  env['PATH_INFO'].sub!(%r{^/assets}, '')
  settings.assets.call(env)
end

get '/' do
  erb :index
end