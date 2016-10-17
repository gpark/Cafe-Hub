class PreferenceEntry < ActiveRecord::Base
	belongs_to :preference
	has_many :entry_occurences
	accepts_nested_attributed_for :entry_occurences, allow_destroy: true 
end
