class Activity < ApplicationRecord
	# Relationships
	belongs_to :client
	belongs_to :eventable, polymorphic: true
end
