class WorkoutsController < ApplicationController

	def workout
		@user = current_user
		exercises = params[:exercises]
		pictures = params[:images]
		parsed_date = DateTime.strptime(params[:date], '%m/%d/%Y')
		@saved = false

		if params[:exercises].nil?
    	respond_to do |format|
    		flash.now[:info] = "No exercises."
        format.js {  render file: "/app/views/layouts/notice.js.erb" }
    	end
    	return   
    end

		@workout = @user.workouts.create(date: parsed_date)

		exercises.each do |name, sets|
			exercise = @workout.exercises.create(name: name)
			sets.each do |setNum, set|	

				xset = exercise.xsets.create(number: setNum)
				xset.create_rep(weight: set[0], reps: set[1])
			
			end
		end

		if pictures != nil 
			pictures.each_with_index do |picture, index|
				@picture = Picture.new(user_id: @user.id, workout_id: @workout.id, attachment: params[:images][index])
				if @picture.save
					@saved = true				
				else
					@saved = false
							
				end
			end

			if @saved = true 
				respond_to do |format|
					format.js { render file: "/app/views/users/workouts/add_workout.js.erb", :locals => {:workout => @workout} }
				end
			else
				flash.now[:error] = "Error."	
				respond_to do |format|
					format.js { render file: "/app/views/layouts/notice.js.erb" }
				end
			end
		end 
	end

private


end









