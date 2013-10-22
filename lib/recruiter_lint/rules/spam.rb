module RecruiterLint
  module Rules
    class Spam < Rule
      name "Newsletter"
      desc "Don't spam candidates with canned emails"

      def run(spec, result)
        canned_words = [
          'unsubscribe',
        ]

        canned_mentions = spec.contains?(canned_words)

        if canned_mentions.any?
          result.add_warning "Don't spam candidates with canned emails", canned_mentions
          result.add_recruiter_fail_points canned_mentions.length
        end
      end
    end
  end
end