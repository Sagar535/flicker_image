class Api::ImageDetailController < ApplicationController
	before_action :set_image_detail, only: [:show, :update, :destroy]

	# GET /image_details
	def index
		@image_details = ImageDetail.all
		render json: @image_details, status: 200
	end

	# POST /image_details
	def create
		@image_detail = ImageDetail.create!(image_detail_params)
		json_response(@image_detail, :created)
	end

	# GET /image_details/:id
	def show
		render json: @image_detail
	end

	# PUT /image_details/:id
	def update
		@image_detail.update(image_detail_params)
		head :no_content
	end

	# DELETE /image_details/:id
	def destroy
		@image_detail.destroy
		head :no_content
	end

	# GET /search?tags='football'
	def search
		tag = params['tags']
		unless ImageDetail.images_with_tag_present?(tag)
			pictures = Flickr.flickr.photos(tags: params['tags']) if params['tags'].present?
			pictures ||= Flickr.flickr.recent
			picture_urls = pictures.map {|p| p.url}

			cache_searched_images(tag, picture_urls) 
		else
			pictures = ImageDetail.where(tag: tag).where('expires_at > ?', Time.now)
			picture_urls = pictures.map {|p| p.url}
		end

		render json: picture_urls
	end	

	private

	def image_detail_params
		# whitelist params
		params.permit(:tag)
	end

	def set_image_detail
		@image_detail = ImageDetail.find(params[:id])
	end

	def cache_searched_images(tag, urls)
		expires_at = Time.now + 15.minutes

		pic_urls = urls.map {|url| {tag: tag, url: url, expires_at: expires_at}}
		ImageDetail.insert_all(pic_urls)
	end
end
