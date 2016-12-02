class Facility < ActiveRecord::Base
    has_many :assignments
    
    def all_times
        one_day = "2016-1-1 "
        next_day = "2016-1-2 "
        days = ["su", "m", "tu", "w", "th", "f", "sa"]
        start_times = days.map{|item| self.send(item + "_start")}
        start_times = start_times.select{|elem| elem =~ /\d/}
        end_times = days.map{|item| self.send(item + "_end")}.select{|elem| elem =~ /\d/}
        if start_times.empty? or end_times.empty?
            return []
        end
        start_times.map!{|item| (one_day+item).to_time }
        end_times.map! do |item|
            if item.include? "AM"
                (next_day+item).to_time
            else
                (one_day+item).to_time
            end
        end
        starting = start_times.min
        ending = end_times.max
        times = []
        while starting < ending do
            next_hour = starting + 3600
            times.push(starting.strftime("%I:%M %p") + " - " + next_hour.strftime("%I:%M %p"))
            starting = next_hour
        end
        return times
    end
    
    def assignments_hash (week_id)
        one_day = "2016-1-1 "
        h = {"su": {}, "m": {},"tu":{},"w":{},"th":{},"f":{},"sa":{}}
        if (week_id == 0)
            return h
        end
        for assignment in self.assignments.where(assignments_week_id: week_id) do
            employee = assignment.user.name
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
                    h[day][time_string]["data"].push(employee)
                else
                    h[day][time_string] = {"data" => [employee], "cell_color" => "#FFFFFF", "text_color" =>  "#000000"}
                end
                current_time = next_hour
            end            
        end
        return h
    end
end