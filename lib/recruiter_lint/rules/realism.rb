module RecruiterLint
  module Rules
    class Realism < Rule
      name "Visionary Terminology"
      desc "Terms like \"blue sky\" and \"enlightened\" often indicate that a non technical " +
            "person (perhaps a CEO or stakeholder) has been involved in writing the spec. Be " +
            "down-to-earth, and explain things in plain English."

      def test(spec, result)
        visionary_words = [
          /blue\s*sk(?:y|ies)/, /enlighten(?:ed|ing)?/,
          /green\s*fields?/, /incentivi[sz]e/, "paradigm",
          /producti[sz]e/, /reach(?:ed|ing) out/, /synerg(?:y|ize|ise)/,
          /visionar(?:y|ies)/, /exceptionally/, /greatest/, /rapidly/,
          /opportunity/, /spectacular/, /millions?/,
          /the best/, /resonate/, /background aligns/
        ]

        visionary_mentions = spec.contains?(visionary_words)

        amount = visionary_mentions.length > 2 ? "Lots of" : "Some"

        if visionary_mentions.any?
          result.add_warning "#{amount} \"visionary\" terminology is used", visionary_mentions
          result.add_culture_fail_points visionary_mentions.length / 2.0
          result.add_realism_fail_points visionary_mentions.length / 2.0
        end
      end
    end
  end
end