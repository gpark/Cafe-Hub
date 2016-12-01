class Fixnum
    def to_twelve_form
        if self > 24
            raise 'This method is not applicable for this number'
        elsif self == 0
            return "12:00 AM"
        elsif self < 12
            return self.to_s + ":00 AM"
        elsif self == 12
            return "12:00 PM"
        else
            return (self - 12).to_s + ":00 PM"
        end
    end
    
end