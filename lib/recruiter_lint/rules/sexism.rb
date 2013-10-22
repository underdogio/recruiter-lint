module RecruiterLint
  module Rules
    module Sexism
      class GenderMention < Rule
        name "Gender Mention"
        desc "Mentioning gender in a recruiting email not only limits the number of people likely to " +
              "be interested, but can also have legal implications – it is often discriminatory. " +
              "Check your use of gender-specific terms."

        def run(spec, result)
          gender_words = [
            /boys?/i, /bros?/i, /chicks?/i, /dads?/i, /dudes?/i,
            /fathers?/i, /females?/i, /gentlem[ae]n/i, /girls?/i,
            /grandfathers?/i, /grandmas?/i, /grandmothers?/i, /grandpas?/i,
            /grann(?:y|ies)/i, /guys?/i, /husbands?/i, /lad(?:y|ies)/i, /m[ae]n/i,
            /m[ou]ms?/i, /males?/i, /momm(?:y|ies)/i, /mommas?/i, /mothers?/i, /papas?/i,
            /wi(?:fe|ves)/i, /wom[ae]n/i
          ]

          gender_mentions = spec.contains?(gender_words)

          if gender_mentions.any?
            result.add_error "Gender is mentioned", gender_mentions
            result.add_culture_fail_points gender_mentions.length / 2
          end
        end
      end

      class SexualizedTerms < Rule
        name "Sexualized Terms"
        desc "Terms like \"sexy code\" are often used if the person writing a spec doesn't know " +
              "what they are talking about or can't articulate what good code is. It can also " +
              "be an indicator of bro culture."

        def run(spec, result)
          sexualized_words = ["sexy", "hawt", "phat"]

          sexualized_mentions = spec.contains?(sexualized_words)

          if sexualized_mentions.any?
            result.add_warning "Job uses sexualized terms: " + sexualized_mentions.join(", "), sexualized_mentions
            result.add_culture_fail_points sexualized_mentions.length / 2
          end
        end
      end
    end
  end
end