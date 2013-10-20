module RecruiterLint
  class Result
    attr_reader :errors, :warnings,
                :notices, :fail_points

    def initialize
      @errors   = []
      @warnings = []
      @notices  = []
      @fail_points = {
        culture: 0,
        realism: 0,
        recruiter: 0,
        tech: 0
      }
    end

    def add_error(msg, evidence = [])
      errors << {
        message:  msg,
        evidence: evidence
      }
    end

    def add_warning(msg, evidence = [])
      warnings << {
        message:  msg,
        evidence: evidence
      }
    end

    def add_notice(msg, evidence = [])
      notices << {
        message:  msg,
        evidence: evidence
      }
    end

    def add_fail_points(type, amount)
      fail_points[type] += amount || 1
    end

    def add_culture_fail_points(amount)
      add_fail_points :culture, amount
    end

    def add_realism_fail_points(amount)
      add_fail_points :realism, amount
    end

    def add_recruiter_fail_points(amount)
      add_fail_points :recruiter, amount
    end

    def add_tech_fail_points(amount)
      add_fail_points :tech, amount
    end

    def as_json(options = nil)
      {
        errors: errors,
        warnings: warnings,
        notices: notices,
        fail_points: fail_points
      }
    end

    def to_json(options = nil)
      as_json(options).to_json
    end
  end
end