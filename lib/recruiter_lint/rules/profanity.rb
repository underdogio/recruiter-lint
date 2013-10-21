module RecruiterLint
  module Rules
    class Profanity < Rule
      name "Profanity"
      desc "While swearing in the workplace can be OK, you shouldn't be using profanity in a " +
      "recruiting email – it's unprofessional."

      def run(spec, result)
        swears = [
          "bloody", "bugger", "cunt", "shit",
          /fuck(?:er|ing)?/, /piss(?:ing)?/
        ]

        swear_mentions = spec.contains?(swears)

        if swear_mentions.any?
          result.add_warning "Swearing in a recruiting email isn't very professional", swear_mentions
          result.add_recruiter_fail_points swear_mentions.length
        end
      end
    end
  end
end