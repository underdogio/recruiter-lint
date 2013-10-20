module RecruiterLint
  class Spec
    attr_reader :text

    def initialize(text)
      @text = text
    end

    def length
      text.length
    end

    def contains?(match)
      matches = Array(match)
      matches = matches.map {|m| /\b#{m}\b/i }
      matches.map {|m| text[m] }.compact
    end
  end
end