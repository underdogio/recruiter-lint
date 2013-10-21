module RecruiterLint
  module Rules
    class ChainLetter < Rule
      name "ChainLetter"
      desc "Asking candidates to spam their friends with your emails is a bad idea."

      def run(spec, result)
        chain_words = ['not interested', 'friends', 'share with', 'mass email', 'pass on']

        chain_mentions = spec.contains?(chain_words)

        if chain_mentions.any?
          result.add_warning "Don't ask candiates to forward your emails", chain_mentions
          result.add_recruiter_fail_points 2
        end
      end
    end
  end
end