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
  
end
