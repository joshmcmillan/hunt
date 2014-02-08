class Api::V1::LocationsController < Api::V1::BaseController
  before_action :set_location, only: [:update]
  before_action :set_locatable

  def create
    @location = Location.new(locatable: @locatable)
    respond_to do |format|
      if @location.save
        format.json { head :no_content }
      else
        format.json { render json: @location.errors, status: :unprocessable_entity }        
      end
    end
  end

  def update
  end

  def destroy
  end

  private
  def set_location
  end

  def set_locatable
    resource_name  = request.path.split('/')[3].strip
    parameter_name = :"#{resource_name.singularize}_id"
    class_name     = resource_name.classify.constantize
    @locatable     = class_name.find(params[parameter_name])
  end
end