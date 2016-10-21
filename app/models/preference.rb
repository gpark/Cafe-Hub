class Preference < ActiveRecord::Base
    belongs_to :user
    has_many :preference_entries
    accepts_nested_attributes_for :preference_entries, allow_destroy: true
end
