class AssignmentsWeek < ActiveRecord::Base
    has_many :assignments
    
    def to_s
        return self.start_date.to_s + " to " + self.end_date.to_s
    end
    
    def twelve_to_twentyfour(ampm, num)
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
    
    
    def twentyfour_to_twelve_form(twentyfour_form)
        if twentyfour_form == 0
            return "12:00 AM"
        elsif twentyfour_form < 12
            return twentyfour_form.to_s + ":00 AM"
        elsif twentyfour_form == 12
            return "12:00 PM"
        else
            return (twentyfour_form - 12).to_s + ":00 PM"
        end
    end
    
    
    def user_schedule_helper(start_num, start_ampm, end_num, end_ampm, item, su, m, tu, w, th, f, sa, pref_table)
        start_test = twelve_to_twentyfour(start_ampm, start_num)
        end_test = twelve_to_twentyfour(end_ampm, end_num)
    
    	while start_test < end_test
    		if su
    			pref_table["su"][start_test].push(item)
    		end
    		if m
    			pref_table["m"][start_test].push(item)
    		end
    		if tu
    			pref_table["tu"][start_test].push(item)
    		end
    		if w
    			pref_table["w"][start_test].push(item)
    		end
    		if th
    			pref_table["th"][start_test].push(item)
    		end
    		if f
    			pref_table["f"][start_test].push(item)
    		end
    		if sa
    			pref_table["sa"][start_test].push(item)
    		end	
    		start_test += 1
    	end
    	return pref_table
    end
    

    
    def generate_assignments
        @users = User.all
        @facilities = Facility.all
        available_ppl = {}
    	days = ["su", "m", "tu", "w", "th", "f", "sa"]
        for day in days
        	available_ppl[day] = {0 => [], 1 => [], 2 => [], 3 => [],
        		4 => [], 5 => [], 6 => [], 7 => [],
        		8 => [], 9 => [], 10 => [], 11 => [],
        		12 => [], 13 => [], 14 => [], 15 => [],
        		16 => [], 17 => [], 18 => [], 19 => [],
        		20 => [], 21 => [], 22 => [], 23 => []}
        end
        
        if @users.nil?
            return
        else
            @users.each do |user|
                for pref in user.preferences.all
                    for pref_entry in pref.preference_entries.all
                        type = pref_entry.preference_type
                        if type == "Prefer"
                            for entry_occurence in pref_entry.occurences.all
                                user_id = user.id
                                start_match = /(.*):00 (.*)M/.match(entry_occurence.start_time) #<MatchData "3:00 AM" 1:"3" 2:"A">
                                end_match = /(.*):00 (.*)M/.match(entry_occurence.end_time)
                                available_ppl = user_schedule_helper(start_match[1], start_match[2], end_match[1], end_match[2], user_id, 
                                    entry_occurence.su, entry_occurence.m, entry_occurence.tu, entry_occurence.w, entry_occurence.th, 
                                    entry_occurence.f, entry_occurence.sa, available_ppl)
                            end
                        end
                    end
                end
            end
        end  
        
        
        if @facilities.nil?
            return
        else
            @facilities.each do |facility|
                needed_num = facility.ppl_per_shift
                if not facility.m_start.nil?
                    start_match = /(.*):00 (.*)M/.match(facility.m_start)
                    end_match = /(.*):00 (.*)M/.match(facility.m_end)
                    start_test = twelve_to_twentyfour(start_match[2], start_match[1])
                    end_test = twelve_to_twentyfour(end_match[2], end_match[1])
                	
                	while start_test < end_test
                	    for i in 1..needed_num
                	        if not available_ppl["m"][start_test].empty?
                	            temp_ppl_id = available_ppl["m"][start_test][0]
                	            temp_db_entry = Assignment.new
                	            temp_db_entry.user_id = temp_ppl_id
                	            temp_db_entry.facility_id = facility.id
                	            temp_db_entry.assignments_week_id = self.id
                	            temp_db_entry.day = 'm'
                	            temp_db_entry.start_time = twentyfour_to_twelve_form(start_test)
                	            temp_db_entry.end_time = twentyfour_to_twelve_form(start_test + 1)
                	            temp_db_entry.save
                	            available_ppl["m"][start_test].delete_at(0)
                	        end
                	    end
                	    start_test += 1
                	end
                end
                
                if not facility.tu_start.nil?
                    start_match = /(.*):00 (.*)M/.match(facility.tu_start)
                    end_match = /(.*):00 (.*)M/.match(facility.tu_end)
                    start_test = twelve_to_twentyfour(start_match[2], start_match[1])
                    end_test = twelve_to_twentyfour(end_match[2], end_match[1])
                	
                	while start_test < end_test
                	    for i in 1..needed_num
                	        if not available_ppl["tu"][start_test].empty?
                	            temp_ppl_id = available_ppl["tu"][start_test][0]
                	            temp_db_entry = Assignment.new
                	            temp_db_entry.user_id = temp_ppl_id
                	            temp_db_entry.facility_id = facility.id
                	            temp_db_entry.assignments_week_id = self.id
                	            temp_db_entry.day = 'tu'
                	            temp_db_entry.start_time = twentyfour_to_twelve_form(start_test)
                	            temp_db_entry.end_time = twentyfour_to_twelve_form(start_test + 1)
                	            temp_db_entry.save
                	            available_ppl["tu"][start_test].delete_at(0)
                	        end
                	    end
                	    start_test += 1
                	end
                end
                
                if not facility.w_start.nil?
                    start_match = /(.*):00 (.*)M/.match(facility.w_start)
                    end_match = /(.*):00 (.*)M/.match(facility.w_end)
                    start_test = twelve_to_twentyfour(start_match[2], start_match[1])
                    end_test = twelve_to_twentyfour(end_match[2], end_match[1])
                	
                	while start_test < end_test
                	    for i in 1..needed_num
                	        if not available_ppl["w"][start_test].empty?
                	            temp_ppl_id = available_ppl["w"][start_test][0]
                	            temp_db_entry = Assignment.new
                	            temp_db_entry.user_id = temp_ppl_id
                	            temp_db_entry.facility_id = facility.id
                	            temp_db_entry.assignments_week_id = self.id
                	            temp_db_entry.day = 'w'
                	            temp_db_entry.start_time = twentyfour_to_twelve_form(start_test)
                	            temp_db_entry.end_time = twentyfour_to_twelve_form(start_test + 1)
                	            temp_db_entry.save
                	            available_ppl["w"][start_test].delete_at(0)
                	        end
                	    end
                	    start_test += 1
                	end
                end
                
                if not facility.th_start.nil?
                    start_match = /(.*):00 (.*)M/.match(facility.th_start)
                    end_match = /(.*):00 (.*)M/.match(facility.th_end)
                    start_test = twelve_to_twentyfour(start_match[2], start_match[1])
                    end_test = twelve_to_twentyfour(end_match[2], end_match[1])
                	
                	while start_test < end_test
                	    for i in 1..needed_num
                	        if not available_ppl["th"][start_test].empty?
                	            temp_ppl_id = available_ppl["th"][start_test][0]
                	            temp_db_entry = Assignment.new
                	            temp_db_entry.user_id = temp_ppl_id
                	            temp_db_entry.facility_id = facility.id
                	            temp_db_entry.assignments_week_id = self.id
                	            temp_db_entry.day = 'th'
                	            temp_db_entry.start_time = twentyfour_to_twelve_form(start_test)
                	            temp_db_entry.end_time = twentyfour_to_twelve_form(start_test + 1)
                	            temp_db_entry.save
                	            available_ppl["th"][start_test].delete_at(0)
                	        end
                	    end
                	    start_test += 1
                	end
                end
                
                if not facility.f_start.nil?
                    start_match = /(.*):00 (.*)M/.match(facility.f_start)
                    end_match = /(.*):00 (.*)M/.match(facility.f_end)
                    start_test = twelve_to_twentyfour(start_match[2], start_match[1])
                    end_test = twelve_to_twentyfour(end_match[2], end_match[1])
                	
                	while start_test < end_test
                	    for i in 1..needed_num
                	        if not available_ppl["f"][start_test].empty?
                	            temp_ppl_id = available_ppl["f"][start_test][0]
                	            temp_db_entry = Assignment.new
                	            temp_db_entry.user_id = temp_ppl_id
                	            temp_db_entry.facility_id = facility.id
                	            temp_db_entry.assignments_week_id = self.id
                	            temp_db_entry.day = 'f'
                	            temp_db_entry.start_time = twentyfour_to_twelve_form(start_test)
                	            temp_db_entry.end_time = twentyfour_to_twelve_form(start_test + 1)
                	            temp_db_entry.save
                	            available_ppl["f"][start_test].delete_at(0)
                	        end
                	    end
                	    start_test += 1
                	end
                end
                
                if not facility.sa_start.nil? and facility.sa_start != "null"
                    start_match = /(.*):00 (.*)M/.match(facility.sa_start)
                    end_match = /(.*):00 (.*)M/.match(facility.sa_end)
                    start_test = twelve_to_twentyfour(start_match[2], start_match[1])
                    end_test = twelve_to_twentyfour(end_match[2], end_match[1])
                	
                	while start_test < end_test
                	    for i in 1..needed_num
                	        if not available_ppl["sa"][start_test].empty?
                	            temp_ppl_id = available_ppl["sa"][start_test][0]
                	            temp_db_entry = Assignment.new
                	            temp_db_entry.user_id = temp_ppl_id
                	            temp_db_entry.facility_id = facility.id
                	            temp_db_entry.assignments_week_id = self.id
                	            temp_db_entry.day = 'sa'
                	            temp_db_entry.start_time = twentyfour_to_twelve_form(start_test)
                	            temp_db_entry.end_time = twentyfour_to_twelve_form(start_test + 1)
                	            temp_db_entry.save
                	            available_ppl["sa"][start_test].delete_at(0)
                	        end
                	    end
                	    start_test += 1
                	end
                end
                
                if not facility.su_start.nil?
                    start_match = /(.*):00 (.*)M/.match(facility.su_start)
                    end_match = /(.*):00 (.*)M/.match(facility.su_end)
                    start_test = twelve_to_twentyfour(start_match[2], start_match[1])
                    end_test = twelve_to_twentyfour(end_match[2], end_match[1])
                	
                	while start_test < end_test
                	    for i in 1..needed_num
                	        if not available_ppl["su"][start_test].empty?
                	            temp_ppl_id = available_ppl["su"][start_test][0]
                	            temp_db_entry = Assignment.new
                	            temp_db_entry.user_id = temp_ppl_id
                	            temp_db_entry.facility_id = facility.id
                	            temp_db_entry.assignments_week_id = self.id
                	            temp_db_entry.day = 'su'
                	            temp_db_entry.start_time = twentyfour_to_twelve_form(start_test)
                	            temp_db_entry.end_time = twentyfour_to_twelve_form(start_test + 1)
                	            temp_db_entry.save
                	            available_ppl["su"][start_test].delete_at(0)
                	        end
                	    end
                	    start_test += 1
                	end
                end
                
            end
        end
    end
    # def generate_assignments
    #     puts "Algorithm here"
    # end
end
