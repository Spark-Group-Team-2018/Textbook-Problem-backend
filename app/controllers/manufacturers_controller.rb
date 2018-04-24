# Controller in charge of handling manufacturer api requests

class ManufacturersController < ApplicationController

  # apply auth to all excluding read db api requests
  skip_before_action :authenticate_request, only: [:index, :show, :get_existing_manufacturer_by_name]

  # set manufacturer variable for actions relating to a specific manufacturer
  before_action :set_manufacturer, only: [:show, :update, :destroy]

  # retrieve all manufacturers
  def index
    @manufacturers = Manufacturer.all()
    render :json => @manufacturers
  end

  # show a specific manufacturer
  def show
    render :json => @manufacturer
  end

  # Creates a specific manufacturer
  def create
    @new_manufacturer = Manufacturer.new(manufacturer_params)

    if @new_manufacturer.save
      render json: @new_manufacturer, status: :created
    else
      render json: error_message
    end
  end

  # Gets an existing manufacturer by its name
  # if it does not already exist. then return nil (null)

  def get_existing_manufacturer_by_name
    @manufacturer_name  = params[:name]

    @manufacturer = Manufacturer.find_by(name: @manufacturer_name)

    if @manufacturer then
      render json: @manufacturer
    else
      render json: nil
    end

    ## TODO check if manufacturer exists in database. If not, return FALSE

  end

  # Destroys a specific manufacturer
  def destroy
    if @manufacturer.destroy
      render json: {"status": "Destroyed Manufacturer"}, status: :ok
    else
      render json: error_message
    end
  end

  # Update a specific manufacturer
  def update
    if @manufacturer.update_attributes manufacturer_params
      render json: @manufacturer, status: :ok
    else
      render json: error_message
    end
  end

  private

    # default error message
    def error_message
      {"status": "unable to do specified action"}
    end

    # set specific manufacturer for updating, viewing, and deletion requests
    def set_manufacturer
      @manufacturer = Manufacturer.find(params[:id]) rescue nil
      if @manufacturer == nil
        render json: {"status": "manufacturer does not exist"}
      end

    end

    # get manufacturer fields for creation and updating of manufacturers
    def manufacturer_params
      params.require(:manufacturer).permit(:name, :description)
    end

end
