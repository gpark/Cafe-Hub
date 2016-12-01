class Preference < ActiveRecord::Base
    belongs_to :user
    has_many :preference_entries
    accepts_nested_attributes_for :preference_entries, allow_destroy: true
    def self.all_times
        return User.all_times
    end
    
    def entries_hash(start_day="7:00 AM")
        one_day = "2016-1-1 "
        midnight = (one_day + "12:00 AM").to_time
        day_start = (one_day + start_day).to_time
        start_hour = day_start.hour
        days = [:su, :m, :tu, :w, :th, :f, :sa]
        h = {"su": {}, "m": {},"tu":{},"w":{},"th":{},"f":{},"sa":{}}
        for entry in self.preference_entries do
            pref_type = entry.preference_type
            for occurence in entry.occurences do
                starting = (one_day + occurence.start_time).to_time
                ending = (one_day + occurence.end_time).to_time
                if ending < starting
                    ending = ending + 24*60*60
                end
                previous_day = false
                if starting >= midnight and starting < day_start
                    previous_day = true
                end
                for day in h.keys do
                    if occurence.send(day)
                        if previous_day
                            actual_day = days[(days.index(day) - 1) % 7]
                        else
                            actual_day = day
                        end
                        current_time = starting
                        while current_time < ending do
                            next_hour = current_time + 60*60
                            time_string = current_time.strftime("%I:%M %p")  + " - " + next_hour.strftime("%I:%M %p")
                            if h[actual_day].key? time_string
                                h[actual_day][time_string].push(pref_type)
                            else
                                h[actual_day][time_string] = [pref_type]
                            end
                            current_time = next_hour
                            if next_hour.hour == start_hour and next_hour.min == 0
                               actual_day = days[(days.index(actual_day) + 1) % 7]
                            end
                        end
                    end
                end
            end
        end
        return h
    end
end
