class Facility < ActiveRecord::Base
    has_many :assignments
    
    def all_times
        one_day = "2016-1-1 "
        next_day = "2016-1-2 "
        days = ["su", "m", "tu", "w", "th", "f", "sa"]
        start_times = days.map{|item| self.send(item + "_start")}.select{|elem| !elem.include?("Select")}
        end_times = days.map{|item| self.send(item + "_end")}.select{|elem| !elem.include?("Select")}
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
    
    def assignments_hash
        one_day = "2016-1-1 "
        h = {"su": {}, "m": {},"tu":{},"w":{},"th":{},"f":{},"sa":{}}
        for assignment in self.assignments do
            employee = assignment.user.name
            for occurence in assignment.occurences do
                for day in h.keys do
                    if occurence.send(day)
                        starting = (one_day + occurence.start_time).to_time
                        ending = (one_day + occurence.end_time).to_time
                        if ending < starting
                            ending = ending + 24*60*60
                        end
                        while starting < ending do
                            next_hour = starting + 3600
                            current_time = starting.strftime("%I:%M %p")  + " - " + next_hour.strftime("%I:%M %p")
                            if h[day].key? current_time
                                h[day][current_time].push(employee)
                            else
                                h[day][current_time] = [employee]
                            end
                            starting = next_hour
                        end
                    end
                end
            end
        end
        return h
    end
end