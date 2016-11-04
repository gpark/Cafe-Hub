class AssignmentsWeek < ActiveRecord::Base
    has_many :assignments
    
    def to_s
        return self.start_date.to_s + " to " + self.end_date.to_s
    end
    
    def generate_assignments
        puts "Put algorithm here!"
    end
end
