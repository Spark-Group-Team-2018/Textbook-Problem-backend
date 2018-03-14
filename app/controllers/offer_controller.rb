class OfferController < ApplicationController

  before_action :set_offer, only: [:show, :update, :destroy]

  def index
    @offers = Offer.all()
    render :json => @offers
  end

  def show
    render json: @offer
  end

  def create
    @new_offer = Offer.new(offer_params)

    if @new_offer.save
      render json: @new_offer, status: :created
    else
      render json: error_message
    end

  end

  def update

    if @offer.update_attributes(offer_params)
      render json: @offer, status: :updated
    else
      render json: error_message
    end

  end

  def destroy
    if @offer.destroy
      render json: {"status": "Destroyed Offer"}, status: :deleted
    else
      render json: error_message
    end
  end


  private

    def set_offer
      @offer = Offer.find(params[:id])
    end

    def error_message
      {"status": "unable to specified action"}
    end

    def offer_params
      params.require(:offer).permit(:lat, :lon, :price, :is_public, :textbook_id)
    end

end
