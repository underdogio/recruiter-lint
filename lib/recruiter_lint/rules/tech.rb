module RecruiterLint
  module Rules
    module Tech
      class LegacyTech < Rule
        name "Legacy Technology"
        desc "Legacy technologies can reduce the number of people interested in a job. " +
              "Sometimes we can't avoid this, but extreme legacy tech can often indicate that " +
              "a company isn't willing to move forwards or invest in career development."

        def run(spec, result)
          legacy_tech_m = [
            "cobol", "cvs", /front\s*page/i, "sourcesafe",
            /vb\s*6/i, /visual\s*basic\s*6/i, "vbscript", "svn"
          ]

          legacy_tech_mentions = spec.contains?(legacy_tech_m)

          if legacy_tech_mentions.length > 0
            result.add_notice "Legacy technologies found: " + legacy_tech_mentions.join(", "), legacy_tech_mentions
            result.add_tech_fail_points legacy_tech_mentions.length
            result.add_realism_fail_points 1
          end
        end
      end

      class JavaScript < Rule
        name "JavaScript"
        desc "JavaScript is one word. You write JavaScript, not javascripts or java script."

        def run(spec, result)
          javascript_fails = spec.contains?(/(java script|java\s*scripts|javascript)/)

          if javascript_fails.any?
            result.add_error "JavaScript is one word, the \"S\" in \"Script\" is capitilized and there's no \"s\" on the end", javascript_fails
            result.add_recruiter_fail_points javascript_fails.length
          end
        end
      end

      class RubyOnRails < Rule
        name "Ruby On Rails"
        desc "Ruby On Rails is plural – there is more than one rail."

        def run(spec, result)
          rails_fails = spec.contains?("ruby on rail")

          if rails_fails.any?
            result.add_error "Ruby On Rails is plural – there is more than one rail.", rails_fails
            result.add_recruiter_fail_points rails_fails.length
          end
        end
      end
    end
  end
end