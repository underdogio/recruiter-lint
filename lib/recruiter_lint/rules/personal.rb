module RecruiterLint
  module Rules
    class Personal < Rule
      name "Personal"
      desc "Sending canned emails without a name is just rude."

      def test(spec, result)
        personal_words = [
          /Hi\b.+/, /Hey\b.+/, /Dear\b.+/
        ]

        personal_mentions = spec.contains?(personal_words)

        unless personal_mentions.any?
          result.add_warning "Sending canned emails without a name is rude"
          result.add_recruiter_fail_points 2
        end
      end
    end
  end
end