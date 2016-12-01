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
    
end