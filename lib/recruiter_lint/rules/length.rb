module RecruiterLint
  module Rules
    class Length < Rule
      name "Length"
      desc "Don't write a small essay, get to the point."

      def run(spec, result)
        if spec.length > 1200
          result.add_warning "Email is too long - get to the point quicker"
          result.add_recruiter_fail_points 1
        elsif spec.length < 50
          result.add_warning "Email is too short - explain more about the position"
          result.add_recruiter_fail_points 1
        end
      end
    end
  end
end