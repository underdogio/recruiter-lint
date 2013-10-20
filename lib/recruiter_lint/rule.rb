module RecruiterLint
  class Rule
    def self.rules
      @rules ||= []
    end

    def self.inherited(subclass)
      Rule.rules << subclass
    end

    def self.name(val = nil)
      @name = val if val
      @name
    end

    def self.desc(val = nil)
      @desc = val if val
      @desc
    end

    def self.run(spec, result)
      self.new.test(spec, result)
      result
    end

    def test(spec, result)
      raise 'Override me'
    end
  end
end

Dir[File.dirname(__FILE__) + '/rules/*.rb'].sort.each do |path|
  require path
end