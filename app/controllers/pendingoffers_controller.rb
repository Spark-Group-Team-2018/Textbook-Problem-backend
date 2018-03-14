class PendingoffersController < ApplicationController

  def index
    @pendingoffers = PendingOffer.all()
    render json: @pendingoffers
  end

end
