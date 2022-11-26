class SignupsController  < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response 
    rescue_from ActiveRecord::RecordInvalid, with: :render_errors
    

    #POST /signup
    def create
       signup = Signup.create!(signup_params)
      render json: signup.activity, status: :created
    end


    private
    def signup_params
        params.permit(:camper_id,:activity_id, :time)
    end

    def render_not_found_response
        render json: { error: "Signup not found" }, status: :not_found
    end

   def render_errors(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
   end

  

end
