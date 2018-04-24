# Controller tasked with handling textbook api requests

class TextbookController < ApplicationController

  # Apply authentication to all api requests excluding show-db textbook actions
  skip_before_action :authenticate_request, only: [:index, :show]

  # Retrieve specific textbook as per textbook_id for viewing, updating, and destroying said textbook
  before_action :set_textbook, only: [:show, :update, :destroy]

  # Show all textbooks
  def index
    @textbooks = Textbook.all().as_json

    @real_textbooks = @textbooks.map do |textbook|
      textbook["textbook_title"] = Book.find(textbook["book_id"]).title
    end

    puts @real_textbooks

    render :json => @textbooks, status: :ok
  end

  # View a specific textbook via textbook_id
  def show
    @special_textbook = @textbook.as_json rescue nil

    if @textbook then
      @special_textbook["textbook_title"] = Book.find(@textbook["book_id"]).title
      render :json => @special_textbook, status: :ok
    else
      render :json => {status: 404}
    end

  end

  # Create a new textbook as specified by textbook_params
  def create
    @new_textbook = Textbook.new(textbook_params)

    if @new_textbook.save
      render json: @new_textbook, status: :created
    else
      render json: error_message
    end


  end

  # Update a specific textbook
  def update

    if @textbook.update_attributes(textbook_params)
      render json: @textbook, status: :ok
    else
      render json: error_message
    end

  end

  # Destroy a specific textbook
  def destroy

    if @textbook.destroy
      render json: {"status": "Destroyed Textbook"}, status: :ok
    else
      render json: error_message
    end

  end


  private

    # Retrieve the specific textbook for viewing, deletion, updating as specified by textbook_id
    def set_textbook
      @textbook = Textbook.find(params[:id])
    end

    # Retrieve textbook fields that will be used for creation and updating as sent by client
    def textbook_params
      params.require(:textbook).permit(:book_id, :user_id, :status, :owner_description, :is_public)
    end

    # Default error message
    def error_message
      {"status": "unable to do specified action"}
    end

end
