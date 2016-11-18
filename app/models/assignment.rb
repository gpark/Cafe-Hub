class Assignment < ActiveRecord::Base
    belongs_to :user
    belongs_to :facility
    belongs_to :assignments_week
    has_one :sub
    
    def to_s
        return self.facility.name + ": " + self.day.capitalize + " " + self.start_time + " - " + self.end_time
    end
end
