module DashboardHelper
    #Checks if the preference is on that day of the week and puts it on the calendar
    def helper_format(type, date, entry_occurence)
        if date.wday == 1 and entry_occurence.m
            helper_format2(type, entry_occurence)
        elsif date.wday == 2 and entry_occurence.tu
            helper_format2(type, entry_occurence)
        elsif date.wday == 3 and entry_occurence.w
            helper_format2(type, entry_occurence)
        elsif date.wday == 4 and entry_occurence.th
            helper_format2(type, entry_occurence)
        elsif date.wday == 5 and entry_occurence.f
            helper_format2(type, entry_occurence)
        elsif date.wday == 6 and entry_occurence.sa
            helper_format2(type, entry_occurence)
        elsif date.wday == 0 and entry_occurence.su
            helper_format2(type, entry_occurence)
        end
    end
    
    #Formatting for post onto calendar
    def helper_format2(type, entry_occurence)
        simple_format("(" + type + ": " + entry_occurence.start_time + " to " + entry_occurence.end_time + ")\n")
    end
end