module RecruiterLint
  module Rules
    class Resume < Rule
      name "Resumes"
      desc "Asking for programmers resume's or CVs is outdated, and requires work " +
           "on their behalf. Really all your need is a GitHub link, which you should have before emailing"

      def test(spec, result)
        deprecated_words = ['CV', /resume/]

        deprecated_mentions = spec.contains?(deprecated_words)

        if deprecated_mentions.any?
          result.add_warning "Don't ask for CVs or Resumes - it shows you haven't done your homework", deprecated_mentions
          result.add_recruiter_fail_points 1
        end
      end
    end
  end
end