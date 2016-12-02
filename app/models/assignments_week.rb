class AssignmentsWeek < ActiveRecord::Base
    has_many :assignments

    def to_s
        return self.start_date.to_s + " to " + self.end_date.to_s
    end
    
    def assign_chosen(chosen, assignment_hash, availabilities, assigned_enough)
        start_time = assignment_hash['start_time']
        day = assignment_hash['day']
        next_hour = start_time+1
        if next_hour == 24
            next_hour = 0
        end
        free_next = true
        for user_id in chosen
            db_entry = Assignment.create(user_id: user_id, facility_id: assignment_hash['facility_id'],  
                            assignments_week_id: self.id, day: day, start_time: start_time.to_twelve_form, 
                            end_time: next_hour.to_twelve_form)
            if user_id == 2
                Sub.create!(assignment_id: db_entry.id, assignments_week_id: self.id, comments: '')   
            end
            availabilities['prefer'][day][start_time].delete(user_id)
            availabilities['dont_care'][day][start_time].delete(user_id)
            availabilities['rather_not'][day][start_time].delete(user_id)
            if user_id != 2 && db_entry.user.hours_assigned(self.id) > 10
               assigned_enough.push(user_id) 
               free_next = false
            end
            if !availabilities['prefer'][day][next_hour].include?(user_id) && !availabilities['dont_care'][day][next_hour].include?(user_id) && !availabilities['rather_not'][day][next_hour].include?(user_id)
                free_next = false
            end
        end 
        return free_next, assigned_enough
    end
    
    def pick_random_assignments(availabilities, assignment_hash, needed_num, assigned_enough, previously_chosen)
        start_time = assignment_hash['start_time']
        day = assignment_hash['day']                            
        if previously_chosen.size > 0
            chosen = previously_chosen
        else
            chosen = Set.new
            choose_from = [availabilities['prefer'][day][start_time], availabilities['dont_care'][day][start_time], availabilities['rather_not'][day][start_time]]
            index = 0
            while chosen.size < needed_num
                still_needed = needed_num - chosen.size
                if index > 2
                    chosen = chosen.to_a if chosen.class == Set
                    chosen.push(2)
                else
                    ppl = choose_from[index].select do |user_id|
                        !assigned_enough.include?(user_id)
                    end
                    newly_chosen = ([ppl.size, still_needed].min).times.map{Random.rand(ppl.size)}.map!{|x| ppl[x]}
                    chosen = chosen + newly_chosen
                end
                index += 1
            end
        end
        free_next, assigned_enough = assign_chosen(chosen, assignment_hash, availabilities, assigned_enough)
        if free_next
	        return assigned_enough, chosen
	    else
	        return assigned_enough, []
        end
    end
    
    def initialize_availabilities
        prefer = {}
        dont_care = {}
        rather_not = {}
        availabilities = {"prefer" => prefer, "dont_care" => dont_care, "rather_not" => rather_not}
    	days = ["su", "m", "tu", "w", "th", "f", "sa"]
        for day in days
            day_hash1 = {}
            day_hash2 = {}
            day_hash3 = {}
            (0..23).each do |hour|
    	        day_hash1[hour] = [] 
    	        day_hash2[hour] = [] 
    	        day_hash3[hour] = [] 
            end
        	prefer[day] = day_hash1
        	dont_care[day] = day_hash2
        	rather_not[day] = day_hash3
        end
        return availabilities
    end
    
    def initialize_no_pref
        no_pref_times = {}
        days = ["su", "m", "tu", "w", "th", "f", "sa"]
        for day in days
        	day_hash = {}
        	(0..23).each do |hour|
        	    day_hash[hour] = true
        	end
        	no_pref_times[day] = day_hash
        end
        return no_pref_times
    end
    
    def populate_preference(pref, availabilities, no_pref_times, user_id)
        pref_entries_hash = pref.entries_hash("12:00 AM")
        pref_entries_hash.each do |cday, time_hash|
            time_hash.each do |time, pref_type|
                pref_type = pref_type["data"]
                twentyfour_form = time.split(" - ")[0].to_twentyfour
                if pref_type.include?("Prefer")
                    availabilities['prefer'][cday.to_s][twentyfour_form].push(user_id)
                elsif pref_type.include?("R/N Work")
                    availabilities['rather_not'][cday.to_s][twentyfour_form].push(user_id)
                end
                no_pref_times[cday.to_s][twentyfour_form] = false
            end
        end    
        return no_pref_times
    end
    
    def calculate_availabilities
        @users = User.where.not(name: 'XX')
        availabilities = initialize_availabilities
        #ASSIGNMENTS & HASH TABLE OF USER PREFERENCES
        if @users.nil?
            return availabilities
        else
            @users.each do |user|
                pref = user.preferences.order(created_at: :desc).first 
                if pref != nil
                    no_pref_times = initialize_no_pref
                    no_pref_times = populate_preference(pref, availabilities, no_pref_times, user.id)
                    no_pref_times.each do |cday, time_hash|
                        time_hash.each do |time, value|
                            if value
                                availabilities['dont_care'][cday][time].push(user.id)
                            end
                        end
                    end
                end
            end
        end 
        return availabilities
    end
    
    def make_assignment_hash(day, start_time, facility)
       return { 'day' => day, 'facility_id' => facility, 'start_time' => start_time}
    end
    
    #Method that is called to create assignments for assignments week
    def generate_assignments
        self.assignments.destroy_all
        @facilities = Facility.all
        availabilities = calculate_availabilities

        # Fill facilities people needs with availabilities
        if @facilities.nil?
            return
        else
            assigned_enough = []
            @facilities.each do |facility|
                needed_num = facility.ppl_per_shift
                counter = 0
                storage = {0 => ['m', facility.m_start, facility.m_end], 1 => ['tu', facility.tu_start, facility.tu_end], 
                            2 => ['w', facility.w_start, facility.w_end], 3 => ['th', facility.th_start, facility.th_end],
        		            4 => ['f', facility.f_start, facility.f_end], 5 => ['sa', facility.sa_start, facility.sa_end], 
        		            6 => ['su', facility.su_start, facility.su_end]}
                while counter < 7
                    current = storage[counter]
                    if not current[1].nil? and not current[1].include?("Select")
                        start_test = storage[counter][1].to_twentyfour
                        end_test = storage[counter][2].to_twentyfour
                        chosen = []
                        if start_test < end_test
                        	while start_test < end_test
                        	    assignment_hash = make_assignment_hash(storage[counter][0], start_test, facility.id)
                        	    assigned_enough, chosen = pick_random_assignments(availabilities, assignment_hash, needed_num, assigned_enough, chosen)
                        	    start_test += 1
                        	end
                    	else
                    	    while start_test < 24
                                assignment_hash = make_assignment_hash(storage[counter][0], start_test, facility.id)               	    
                    	        assigned_enough, chosen = pick_random_assignments(availabilities, assignment_hash, needed_num, assigned_enough, chosen)
                        	    start_test += 1
                    	    end
                    	    
                    	    if counter == 6
                    	        temp_counter = 0
                    	    else
                    	        temp_counter = counter + 1
                    	    end
                    	    
                    	    temp_start = 0
                    	    while temp_start < end_test
                                assignment_hash = make_assignment_hash(storage[temp_counter][0], temp_start, facility.id)              	    
                    	        assigned_enough, chosen = pick_random_assignments(availabilities, assignment_hash, needed_num, assigned_enough, chosen)                        	        
                        	    temp_start += 1                        	        
                    	    end
                        end
                    end
                    counter += 1
                end
            end
        end
    end
end