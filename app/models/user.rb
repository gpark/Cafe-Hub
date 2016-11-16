class User < ActiveRecord::Base
  has_many :preferences
  has_many :assignments
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  attr_accessor :sign_up_code
  validates :sign_up_code,
    on: :create,
    presence: true,
    inclusion: { in: [Setting.sign_up_code] }
  validates :name,
    presence: true
    
  def admin?
    admin
  end

  def hours_assigned(week_id)
    total_hours = 0
    for assignment in self.assignments.where("assignments_week_id="+week_id.to_s)
      for occurence in assignment.occurences do
        start_time = occurence.start_time.to_time
        end_time = occurence.end_time.to_time
        if (end_time < start_time)
          end_time += 60*60*24
        end
        occurence_hours = (end_time - start_time) / 3600
        for day in ["m", "tu", "w", "th", "f", "sa", "su"] do
          if occurence.send(day)
            total_hours += occurence_hours
          end
        end
      end
    end
    return total_hours
  end
  
  def assignments_hash (week_id)
    one_day = "2016-1-1 "
    midnight = (one_day + "12:00 AM").to_time
    day_start = (one_day + "7:00 AM").to_time
    days = [:su, :m, :tu, :w, :th, :f, :sa]
    h = {"su": {}, "m": {},"tu":{},"w":{},"th":{},"f":{},"sa":{}}
    if (week_id == 0)
        return h
    end
    for assignment in self.assignments.where("assignments_week_id="+week_id.to_s) do
        facility = Facility.find(assignment.facility_id).name
        for occurence in assignment.occurences do
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
                            h[actual_day][time_string].push(facility)
                        else
                            h[actual_day][time_string] = [facility]
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
