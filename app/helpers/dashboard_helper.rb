module DashboardHelper
    # def calendar_show_preferences
    #     week_calendar number_of_weeks: 1 do |date|
    #         date.strftime('%b %d %Y')
    #         @preferences.each do |preference|
    #             for preference_entry in preference.preference_entries.all
    #                 type = preference_entry.preference_type
    #                 for entry_occurence in preference_entry.entry_occurences.all
    #                     if date.wday == 1 and entry_occurence.m
    #                         helper_format(entry_occurence.start_time, entry_occurence.end_time, type)
    #                     elsif date.wday == 2 and entry_occurence.tu
    #                         helper_format(entry_occurence.start_time, entry_occurence.end_time, type)
    #                     elsif date.wday == 3 and entry_occurence.w
    #                         helper_format(entry_occurence.start_time, entry_occurence.end_time, type)
    #                     elsif date.wday == 4 and entry_occurence.th
    #                         helper_format(entry_occurence.start_time, entry_occurence.end_time, type)
    #                     elsif date.wday == 5 and entry_occurence.f
    #                         helper_format(entry_occurence.start_time, entry_occurence.end_time, type)
    #                     elsif date.wday == 6 and entry_occurence.sa
    #                         helper_format(entry_occurence.start_time, entry_occurence.end_time, type)
    #                     elsif date.wday == 0 and entry_occurence.su
    #                         helper_format(entry_occurence.start_time, entry_occurence.end_time, type)
    #                     end
    #                 end
    #             end
    #         end
    #     end
    # end
    
    # def helper_format(start_time, end_time, type)
    #     simple_format("(" + type + ": " + start_time.to_s + " to " + end_time.to_s + ")\n")
    # end
end