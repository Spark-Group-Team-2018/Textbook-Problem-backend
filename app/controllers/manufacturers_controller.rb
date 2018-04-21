class ManufacturersController < ApplicationController

  skip_before_action :authenticate_request, only: [:index, :show, :get_existing_manufacturer_by_name]
  before_action :set_manufacturer, only: [:show, :update, :destroy]

  def index
    @manufacturers = Manufacturer.all()
    render :json => @manufacturers
  end

  def show
    render :json => @manufacturer
  end

  def create
    @new_manufacturer = Manufacturer.new(manufacturer_params)

    if @new_manufacturer.save
      render json: @new_manufacturer, status: :created
    else
      render json: error_message
    end
  end


  # TODO check if manufacturer exists
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

  def destroy
    if @manufacturer.destroy
      render json: {"status": "Destroyed Manufacturer"}, status: :ok
    else
      render json: error_message
    end
  end

  def update
    if @manufacturer.update_attributes manufacturer_params
      render json: @manufacturer, status: :ok
    else
      render json: error_message
    end
  end

  private

    def error_message
      {"status": "unable to do specified action"}
    end

    def set_manufacturer
      @manufacturer = Manufacturer.find(params[:id]) rescue nil
      if @manufacturer == nil
        render json: {"status": "manufacturer does not exist"}
      end

    end

    def manufacturer_params
      params.require(:manufacturer).permit(:name, :description)
    end

end
