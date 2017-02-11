class PreferenceEntry < ActiveRecord::Base
	belongs_to :preference
	has_many :occurences, dependent: :destroy
	accepts_nested_attributes_for :occurences, allow_destroy: true
end
