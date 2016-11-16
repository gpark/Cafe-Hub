class Assignment < ActiveRecord::Base
    belongs_to :user
    has_one :sub
    has_many :occurences
    belongs_to :facility
    belongs_to :assignments_week
    accepts_nested_attributes_for :occurences, allow_destroy: true
end
