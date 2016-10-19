class PreferenceEntry < ActiveRecord::Base
	belongs_to :preference
	has_many :entry_occurences
	accepts_nested_attributes_for :entry_occurences, allow_destroy: true 
end
