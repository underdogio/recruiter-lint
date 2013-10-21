module RecruiterLint
  module Rules
    class Informality < Rule
      name "Informality"
      desc "Don't be unecessarily informal"

      def test(spec, result)
        informal_words = [
          /want(ed)? to check in/,
          /r\.e\./i,
          /just sent you/,
          /How are you/,
          /Hope all is well/,
          /you'd be perfect for/,
          /perfectly suited/,
          /wonderful day/
        ]

        informal_mentions = spec.contains?(informal_words)

        if informal_mentions.any?
          result.add_warning "Unless you know the candidate, don't pretend you do", informal_mentions
          result.add_recruiter_fail_points informal_mentions.length
        end
      end
    end
  end
end