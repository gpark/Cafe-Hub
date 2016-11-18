class Sub < ActiveRecord::Base
    belongs_to :assignment
    belongs_to :assignments_week
end
