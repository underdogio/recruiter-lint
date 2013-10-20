module RecruiterLint
  module Rules
    class Bubble < Rule
      name "Job \"Titles\""
      desc "Referring to tech people as Ninjas or similar devalues the work that they do and " +
           "shows a lack of respect and professionalism. It's also rather cliched and can be " +
           "an immediate turn-off to many people."

      def test(spec, result)
        bubble_job_titles = [
          /gurus?/, /hero(:?es)/, /ninjas?/,
          /rock\s*stars?/, /super\s*stars?/
        ]

        bubble_job_mentions = spec.contains?(bubble_job_titles)

        if bubble_job_mentions.any?
          result.add_warning "Tech people are not ninjas, rock stars, gurus or superstars", bubble_job_mentions
          result.add_culture_fail_points bubble_job_mentions.length / 2.0
          result.add_realism_fail_points 1
        end
      end
    end
  end
end