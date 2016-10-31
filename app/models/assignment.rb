class Assignment < ActiveRecord::Base
    belongs_to :user
    has_many :occurences
    has_one :facility
    belongs_to :assignments_week
    accepts_nested_attributes_for :occurences, allow_destroy: true
end
