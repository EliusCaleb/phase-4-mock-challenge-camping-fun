class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response 
    rescue_from ActiveRecord::RecordInvalid, with: :render_errors
    
    #GET /campers
    def index
        campers = Camper.all 
        render json: campers
    end

    #GET /campers/:id
    def show
        camper = find_camper
        render json: camper, serializer: CamperActivitySerializer
    end 

    

    # POST /campers
  def create
    camper = Camper.create!(camper_params)
    render json: camper, status: :created
  end


    private
    def camper_params
        params.permit(:name,:age)
    end

    def find_camper
        Camper.find(params[:id])
    end

    def render_not_found_response
        render json: { error: "Camper not found" }, status: :not_found
   end

   def render_errors(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
   end
end
 