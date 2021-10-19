class ImageDetail < ApplicationRecord
	before_create :set_expires_at
	after_initialize :set_defaults

	def self.images_with_tag_present?(tag)
		ImageDetail.where(tag: tag).where('expires_at > ?', Time.now).present?
	end

	def valid?
		expires_at > Time.now
	end

	def expired?
		!valid?
	end

	private

	def set_expires_at
		self.expires_at = Time.now + 15.minutes
	end

	def set_defaults
    	self.created_at = Time.now if self.new_record?
	end
end
