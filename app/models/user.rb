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
        start_time = assignment.start_time.to_time
        end_time = assignment.end_time.to_time
        if (end_time < start_time)
          end_time += 60*60*24
        end
        assignment_hours = (end_time - start_time) / 3600
        total_hours += assignment_hours
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
      facility = assignment.facility.name
      start_time = assignment.start_time
      end_time = assignment.end_time
      if start_time == nil || end_time == nil
        start_time = "12:00 AM"
        end_time = "1:00 AM"
      end
      starting = (one_day + start_time).to_time
      ending = (one_day + end_time).to_time
      if ending <= starting
        ending = ending + 24*60*60
      end
      previous_day = false
      if starting >= midnight and starting < day_start
        previous_day = true
      end        
      day = assignment.day
      if day == nil
        day = "su"
      end
      day = day.to_sym
      if previous_day
        actual_day = days[(days.index(day) - 1) % 7]
      else
        actual_day = day
      end        
      current_time = starting
      while current_time < ending do
        next_hour = current_time + 3600
        time_string = current_time.strftime("%I:%M %p")  + " - " + next_hour.strftime("%I:%M %p")
        if h[day].key? time_string
          h[day][time_string].push(facility)
        else
          h[day][time_string] = [facility]
        end
        current_time = next_hour
        if next_hour.hour == 7 and next_hour.min == 0
          actual_day = days[(days.index(actual_day) + 1) % 7]
        end
      end           
    end
    return h
  end
  
  def self.all_times
    current_time = "2016-1-1 7:00 AM".to_time
    end_time = "2016-1-2 7:00 AM".to_time
    times = []
    while current_time < end_time do
      next_hour = current_time + 60*60
      times.push(current_time.strftime("%I:%M %p") + " - " + next_hour.strftime("%I:%M %p"))
      current_time = next_hour
    end
    return times
  end
  
end
