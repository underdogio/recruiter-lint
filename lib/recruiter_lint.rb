module RecruiterLint
  def self.run(text)
    spec   = Spec.new(text)
    result = Result.new

    Rule.rules.each do |r|
      r.run(spec, result)
    end

    result
  end
end

require 'recruiter_lint/result'
require 'recruiter_lint/spec'
require 'recruiter_lint/rule'