module RecruiterLint
  module Rules
    class BroCulture < Rule
      name "Bro Terminology"
      desc "Bro culture terminology can really reduce the number of people likely to show " +
            "interest, both male and female. It discriminates against anyone who doesn't fit " +
            "into a single gender-specific archetype."

      def run(spec, result)
        bro_words    = [/bros?/i, "crank", "crush", /dude(?:bro)?s?/i, "skillz"]
        bro_mentions = spec.contains?(bro_words)
        amount       = bro_mentions.length > 2 ? "Lots of" : "Some"

        if bro_mentions.any?
          result.add_warning "#{amount} \"bro culture\" terminology is used", bro_mentions
          result.add_culture_fail_points bro_mentions.length
        end
      end
    end
  end
end