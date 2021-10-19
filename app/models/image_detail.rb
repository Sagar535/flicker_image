class ImageDetail < ApplicationRecord
	before_create :set_expires_at
	after_initialize :set_defaults

	private

	def set_expires_at
		self.expires_at = Time.now + 15.minutes
	end

	def set_defaults
    	self.created_at = Time.now if self.new_record?
	end
end
