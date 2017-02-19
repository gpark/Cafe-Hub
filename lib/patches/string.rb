class String
    def to_twentyfour
        matches = /(.*):00 (.*)M/.match(self) #<MatchData "3:00 AM" 1:"3" 2:"A">
        if matches == nil
            raise 'This method is not applicable for the string: ' + self
        end
        ampm = matches[2]
        num = matches[1]
        if ampm == "P"
            if num == "12"
                return 12
            else
                return num.to_i + 12
            end
        elsif ampm == "A"
            if num == "12"
                return 0
            else
                return num.to_i
            end
        end
    end

    def to_hr_form
        matches = /(.*) (.*):(.*) (.*)M/.match(self) #<MatchData "M 3:30 AM" 1:"M" 2:"3" 3:"30" 4:"A">
        if matches == nil
            raise 'This method is not applicable for the string: ' + self
        end
        day = ["Su", "M", "Tu", "W", "Th", "F", "Sa"].index(matches[1])
        hr = matches[2]
        min = matches[3]
        ampm = matches[4]
        if hr == "12"
            hr = "0"
        end
        total = (day * 48) + hr.to_i * 2
        if min == "30"
            total += 1
        end
        if ampm == "P"
            total += 24
        end
        return total
    end

end
