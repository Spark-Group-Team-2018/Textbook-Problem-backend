# Controller in charge of handling pending offer api requests

class PendingoffersController < ApplicationController

  # apply authentication to all requests excluding read-db api requests for pending offers
  skip_before_action :authenticate_request, only: [:index, :show]

  # Retrieve the specific pending offer based off client criteria for showing, updating, and destroying of said pending-offer
  before_action :set_pendingoffer, only: [:show, :update, :destroy]

  # View all pending offers
  def index
    @pendingoffers = PendingOffer.all()
    render json: @pendingoffers
  end

  # Show specific pending offer by pending_offer_id
  def show
    render json: @pendingoffer
  end

  # Create a new pending offer
  def create

    @new_pending_offer = PendingOffer.new(pendingoffer_params)

    if @new_pending_offer.save
      render json: @new_pending_offer, status: :created
    else
      render json: error_message
    end

  end

  # Update a existing pending offer
  def update

    if @pendingoffer.update_attributes(pendingoffer_params)
      render json: @pendingoffer, status: :ok
    else
      render json: error_message
    end


  end

  # Destroy an existing pending offer
  def destroy

    if @pendingoffer.destroy
      render json: {"status": "Destroyed pending offer"}, status: :ok
    else
      render json: error_message
    end

  end

  private

    # Set the specific offer that will be updated, viewed, destroyed as specified by client via pending offer id
    def set_pendingoffer
      @pendingoffer = PendingOffer.find(params[:id])
    end

    # Set the pending offer fields that will be used for creation and deletion of offers as requested by client
    def pendingoffer_params
      params.require(:pendingoffer).permit(:offer_id, :buyer_id)
    end

    # default error message
    def error_message
      {"status": "unable to do specified action"}
    end

end
