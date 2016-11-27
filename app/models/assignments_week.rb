class AssignmentsWeek < ActiveRecord::Base
    has_many :assignments
    
    #TODO LIST
        #Write Tests
        #Prevent overload to workers in terms of hours
        #Include blanks and R/N Work hours to fill
    def to_s
        return self.start_date.to_s + " to " + self.end_date.to_s
    end

    #Sets time from 12 hour clock to 24 hour clock, used to fill in hash table from start to end time
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
    
    #Switches twenty four hour clock cycle to 12 hour clock cycle in string form
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
    
    #Fills in hash table with the user's id if they prefer those times to eventually be selected
    def user_schedule_helper(start_test, end_test, item, su, m, tu, w, th, f, sa, pref_table) 
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
    
    #Method that is called to create assignments for assignments week
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

        #ASSIGNMENTS & HASH TABLE OF USER PREFERENCES
        if @users.nil?
            return
        else
            @users.each do |user|
                pref = user.preferences.order(created_at: :desc).first 
                if pref != nil
                    for pref_entry in pref.preference_entries.all
                        type = pref_entry.preference_type
                        if type == "Prefer"
                            puts 5
                            for entry_occurence in pref_entry.occurences.all
                                user_id = user.id
                                start_match = /(.*):00 (.*)M/.match(entry_occurence.start_time) #<MatchData "3:00 AM" 1:"3" 2:"A">
                                end_match = /(.*):00 (.*)M/.match(entry_occurence.end_time)
                                starting = twelve_to_twentyfour(start_match[2], start_match[1])
                                ending = twelve_to_twentyfour(end_match[2], end_match[1])
                                available_ppl = user_schedule_helper(starting, ending, user_id, 
                                    entry_occurence.su, entry_occurence.m, entry_occurence.tu, entry_occurence.w, entry_occurence.th, 
                                    entry_occurence.f, entry_occurence.sa, available_ppl)
                            end
                        end
                    end
                end
            end
        end  

        #Fill facilities people needs with availabilities
        if @facilities.nil?
            return
        else
            @facilities.each do |facility|
                needed_num = facility.ppl_per_shift
                counter = 0
                storage = {0 => ['m', facility.m_start, facility.m_end], 1 => ['tu', facility.tu_start, facility.tu_end], 
                            2 => ['w', facility.w_start, facility.w_end], 3 => ['th', facility.th_start, facility.th_end],
        		            4 => ['f', facility.f_start, facility.f_end], 5 => ['sa', facility.sa_start, facility.sa_end], 
        		            6 => ['su', facility.su_start, facility.su_end]}
                while counter < 7
                    if not storage[counter][1].nil?
                        start_match = /(.*):00 (.*)M/.match(storage[counter][1])
                        end_match = /(.*):00 (.*)M/.match(storage[counter][2])
                        if not start_match.nil?
                            start_test = twelve_to_twentyfour(start_match[2], start_match[1])
                            end_test = twelve_to_twentyfour(end_match[2], end_match[1])
                            
                            if start_test < end_test
                            	while start_test < end_test
                            	    ppl = available_ppl[storage[counter][0]][start_test]
                            	    if not ppl.empty?
                            	        chosen = ([ppl.size, needed_num].min).times.map{Random.rand(ppl.size)}
                            	        for index in chosen
                            	            db_entry = Assignment.new
                            	            db_entry.user_id = ppl[index]
                            	            db_entry.facility_id = facility.id
                            	            db_entry.assignments_week_id = self.id
                            	            db_entry.day = storage[counter][0]
                            	            db_entry.start_time = twentyfour_to_twelve_form(start_test)
                            	            db_entry.end_time = twentyfour_to_twelve_form(start_test + 1)
                            	            db_entry.save
                            	        end
                            	    end
                            	    start_test += 1
                            	end
                        	else
                        	    while start_test < 24
                        	        ppl = available_ppl[storage[counter][0]][start_test]
                            	    if not ppl.empty?
                            	        chosen = ([ppl.size, needed_num].min).times.map{Random.rand(ppl.size)}
                            	        for index in chosen
                            	            db_entry = Assignment.new
                            	            db_entry.user_id = ppl[index]
                            	            db_entry.facility_id = facility.id
                            	            db_entry.assignments_week_id = self.id
                            	            db_entry.day = storage[counter][0]
                            	            db_entry.start_time = twentyfour_to_twelve_form(start_test)
                            	            db_entry.end_time = twentyfour_to_twelve_form(start_test + 1)
                            	            db_entry.save
                            	        end
                            	    end
                            	    start_test += 1
                        	    end
                        	    
                        	    if counter == 6
                        	        temp_counter = 0
                        	    else
                        	        temp_counter = counter + 1
                        	    end
                        	    
                        	    temp_start = 0
                        	    while temp_start < end_test
                        	        ppl = available_ppl[storage[temp_counter][0]][temp_start]
                            	    if not ppl.empty?
                            	        chosen = ([ppl.size, needed_num].min).times.map{Random.rand(ppl.size)}
                            	        for index in chosen
                            	            db_entry = Assignment.new
                            	            db_entry.user_id = ppl[index]
                            	            db_entry.facility_id = facility.id
                            	            db_entry.assignments_week_id = self.id
                            	            db_entry.day = storage[temp_counter][0]
                            	            db_entry.start_time = twentyfour_to_twelve_form(temp_start)
                            	            db_entry.end_time = twentyfour_to_twelve_form(temp_start + 1)
                            	            db_entry.save
                            	        end
                            	    end
                            	    temp_start += 1                        	        
                        	    end
                            end
                        end
                    end
                    counter += 1
                end
            end
        end
    end
end