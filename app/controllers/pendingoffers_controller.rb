class PendingoffersController < ApplicationController

  skip_before_action :authenticate_request, only: [:index, :show]
  before_action :set_pendingoffer, only: [:show, :update, :destroy]

  def index
    @pendingoffers = PendingOffer.all()
    render json: @pendingoffers
  end

  def show
    render json: @pendingoffer
  end

  def create

    @new_pending_offer = PendingOffer.new(pendingoffer_params)

    if @new_pending_offer.save
      render json: @new_pending_offer, status: :created
    else
      render json: error_message
    end

  end

  def update

    if @pendingoffer.update_attributes(pendingoffer_params)
      render json: @pendingoffer, status: :ok
    else
      render json: error_message
    end


  end

  def destroy

    if @pendingoffer.destroy
      render json: {"status": "Destroyed pending offer"}, status: :ok
    else
      render json: error_message
    end

  end

  private

    def set_pendingoffer
      @pendingoffer = PendingOffer.find(params[:id])
    end

    def pendingoffer_params
      params.require(:pendingoffer).permit(:offer_id, :buyer_id)
    end

    def error_message
      {"status": "unable to do specified action"}
    end


end
