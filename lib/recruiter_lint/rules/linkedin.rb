module RecruiterLint
  module Rules
    class LinkedIn < Rule
      name "LinkedIn"
      desc "The vast majority of softare engineers don't want to use LinkedIn."

      def run(spec, result)
        deprecated_words = ['LinkedIn']

        deprecated_mentions = spec.contains?(deprecated_words)

        if deprecated_mentions.any?
          result.add_warning "Don't use or mention LinkedIn to candidates", deprecated_mentions
          result.add_recruiter_fail_points 1
        end
      end
    end
  end
end