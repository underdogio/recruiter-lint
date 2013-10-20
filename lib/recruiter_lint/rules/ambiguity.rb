module RecruiterLint
  module Rules
    class Ambiguity < Rule
      name "Ambiguity"
      desc "It's absolutely crucial you include the name of your company or client in the email."

      def test(spec, result)
        deprecated_words = ['client']

        deprecated_mentions = spec.contains?(deprecated_words)

        if deprecated_mentions.any?
          result.add_warning "You must include your company's name", deprecated_mentions
          result.add_recruiter_fail_points 1
        end
      end
    end
  end
end