module RecruiterLint
  module Rules
    class Realism < Rule
      name "Visionary Terminology"
      desc "Terms like \"blue sky\" and \"enlightened\" often indicate that a non technical " +
            "person (perhaps a CEO or stakeholder) has been involved in writing the spec. Be " +
            "down-to-earth, and explain things in plain English."

      def run(spec, result)
        visionary_words = [
          /blue\s*sk(?:y|ies)/i, /enlighten(?:ed|ing)?/i,
          /green\s*fields?/i, /incentivi[sz]e/i, "paradigm",
          /producti[sz]e/i, /reach(?:ed|ing) out/i, /synerg(?:y|ize|ise)/i,
          /visionar(?:y|ies)/i,
          'exceptionally', 'greatest', 'rapidly',
          'spectacular', 'millions?',
          'the best', 'resonate', 'background aligns',
          'cool', 'hip'
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