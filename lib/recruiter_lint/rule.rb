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
      result.context(self) do
        self.new.run(spec, result)
      end

      result
    end

    def self.as_json(options = nil)
      {
        name: name,
        desc: desc
      }
    end

    def self.to_json(options = nil)
      as_json(options).to_json
    end

    def run(spec, result)
      raise 'Override me'
    end
  end
end

Dir[File.dirname(__FILE__) + '/rules/*.rb'].sort.each do |path|
  require path
end