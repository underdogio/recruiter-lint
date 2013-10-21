module RecruiterLint
  module Rules
    class JobDescription < Rule
      name "Job Description"
      desc "Asking candidates to look external job description shows you haven't put the effort in."

      def run(spec, result)
        job_desc_words = [/job descriptions?/, /.*bit\.ly.*/, /advert/]

        job_desc_mentions = spec.contains?(job_desc_words)

        if job_desc_mentions.any?
          result.add_warning "Don't ask candiates to view a separate job description", job_desc_mentions
          result.add_recruiter_fail_points 1
        end
      end
    end
  end
end