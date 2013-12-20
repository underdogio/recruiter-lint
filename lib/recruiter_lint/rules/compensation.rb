module RecruiterLint
  module Rules
    class Compensation < Rule
      name "Compensation"
      desc "Don't discuss compensation - it seems desperate."

      def run(spec, result)
        comp_words = [
          "pay", "bonus", "stock", "salary", "shares",
          "equity", "options", "compensation"
        ]

        comp_mentions = spec.contains?(comp_words)

        if comp_mentions.any?
          result.add_warning "Unless this is an offer email, don't discuss compensation", comp_mentions
          result.add_recruiter_fail_points comp_mentions.length
        end
      end
    end
  end
end