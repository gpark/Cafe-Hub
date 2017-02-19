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

    def to_timestring
      if self > 336
          raise 'This method is not applicable for this number'
      end
      # // 48 to determine day (Sunday = 0, Saturday = 6)
      # % 48 to determine time
      day_of_week = ["Su", "M", "Tu", "W", "Th", "F", "Sa"]
      day_str = day_of_week[(self / 48).floor]
      time = ((self % 48) / 2).floor
      hr = ":00"
      if self % 2 != 0 # on the half hour
        hr = ":30"
      end
      ampm = " AM"
      if time >= 12 # AM
        ampm = " PM"
        time = time - 12
      end
      if time == 0
        time = 12
      end
      return day_str + " " + time.to_s + hr + ampm
    end

end
