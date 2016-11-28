class Preference < ActiveRecord::Base
    belongs_to :user
    has_many :preference_entries
    accepts_nested_attributes_for :preference_entries, allow_destroy: true
    def self.all_times
        current_time = "2016-1-1 7:00 AM".to_time
        end_time = "2016-1-2 7:00 AM".to_time
        times = []
        while current_time < end_time do
            next_hour = current_time + 30*60
            times.push(current_time.strftime("%I:%M %p") + " - " + next_hour.strftime("%I:%M %p"))
            current_time = next_hour
        end
        return times
    end
    
    def entries_hash
        one_day = "2016-1-1 "
        midnight = (one_day + "12:00 AM").to_time
        day_start = (one_day + "7:00 AM").to_time
        days = [:su, :m, :tu, :w, :th, :f, :sa]
        type_colors = {"Prefer" => ["#FFFFFF", "#0000FF"], "Class" => ["#696969", "#FF0000"], "R/N Work" => ["#A9A9A9", "#FFFFFF"], "Obligation" => ["#696969", "#000000"]}
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
                            next_hour = current_time + 30*60
                            time_string = current_time.strftime("%I:%M %p")  + " - " + next_hour.strftime("%I:%M %p")
                            if h[actual_day].key? time_string
                                h[actual_day][time_string]["data"].push(pref_type)
                            else
                                h[actual_day][time_string] = {"data" => [pref_type], "cell_color" => type_colors[pref_type][0], "text_color" =>  type_colors[pref_type][1]}
                                if pref_type == "Obligation"
                                    h[actual_day][time_string]["hover_text"] = entry.comments
                                end
                            end
                            current_time = next_hour
                            if next_hour.hour == 7 and next_hour.min == 0
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
