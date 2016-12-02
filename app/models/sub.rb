class Sub < ActiveRecord::Base
    belongs_to :assignment
    belongs_to :assignments_week
    
    def self.hash_view(week_id)
        one_day = "2016-1-1 "
        h = {"su": {}, "m": {},"tu":{},"w":{},"th":{},"f":{},"sa":{}}
        if (week_id == 0)
            return h
        end
        for assignment in Assignment.where("assignments_week_id = ?", week_id.to_s) do
            if assignment.sub == nil
                next
            end
            employee = assignment.user.name
            facility = assignment.facility.name
            to_enter = facility + "-" + employee
            start_time = assignment.start_time
            end_time = assignment.end_time
            if start_time == nil || end_time == nil
                start_time = "12:00 AM"
                end_time = "1:00 AM"
            end
            starting = (one_day + start_time).to_time
            ending = (one_day + end_time).to_time
            if ending <= starting
                ending = ending + 24*60*60
            end
            day = assignment.day
            if day == nil
               day = "su"
            end
            day = day.to_sym
            current_time = starting
            while current_time < ending do
                next_hour = current_time + 3600
                time_string = current_time.strftime("%I:%M %p")  + " - " + next_hour.strftime("%I:%M %p")
                if h[day].key? time_string
                    h[day][time_string]["data"].push(to_enter)
                else
                    h[day][time_string] = {"data" => [to_enter], "cell_color" => "#FFFFFF", "text_color" =>  "#000000"}
                end
                current_time = next_hour
            end            
        end
        return h        
    end
    
end
