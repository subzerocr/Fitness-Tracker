class PicturesController < ApplicationController
	before_action :check_bora, only: [:create, :update]

	def new
		@picture = Picture.new
	end

	def create
		@user = current_user
		@picture = @user.pictures.build(picture_params)
		if @picture.save
			if whitelisted[:bora] = "before"
				@user.before = @picture.id
			elsif whitelisted[:bora] = "after"
				@user.after = @picture.id
			end
  	  render json: { message: "success" }, :status => 200
  	else
  	  #  you need to send an error header, otherwise Dropzone
          #  will not interpret the response as an error:
  	  render json: { error: @picture.errors.full_messages.join(',')}, :status => 400
  	end  
	end

	private

	def check_bora
		unless params[:bora] = "before" || params[:bora] = "after"
			flash.now[:alert] = "Incorrect paramaters."
			return
		end
	end

	def picture_params
		params.require(:picture).permit(:attachment, :caption)
	end	
end
