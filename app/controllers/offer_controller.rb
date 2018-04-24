# Controller in charge of handling Offer Api requests

class OfferController < ApplicationController

  # Apply auth to all actions except read db queries
  skip_before_action :authenticate_request, only: [:index, :show]

  # Set a specific offer based on client request for show, update, destruction of offers
  before_action :set_offer, only: [:show, :update, :destroy]

  # Retrieve all offers
  def index
    @offers = Offer.all()
    render :json => @offers
  end

  # Show a specific offer
  def show
    render json: @offer
  end

  # create a new offer
  def create
    @new_offer = Offer.new(offer_params)

    if @new_offer.save
      render json: @new_offer, status: :created
    else
      render json: error_message
    end

  end

  # Update a specific offer
  def update

    if @offer.update_attributes(offer_params)
      render json: @offer, status: :ok
    else
      render json: error_message
    end

  end

  # Destroy a specific offer
  def destroy
    if @offer.destroy
      render json: {"status": "Destroyed Offer"}, status: :ok
    else
      render json: error_message
    end
  end


  private

    # Get specific offer by id specified for updating, viewing, and destruction of said offer
    def set_offer
      @offer = Offer.find(params[:id])
    end

    # default error message
    def error_message
      {"status": "unable to specified action"}
    end

    # offer fields as sent by client for creation and updating offers
    def offer_params
      params.require(:offer).permit(:lat, :lon, :price, :is_public, :textbook_id)
    end

end
