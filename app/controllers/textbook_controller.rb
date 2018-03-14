class TextbookController < ApplicationController

  before_action :set_textbook, only: [:show, :update, :destroy]

  def index
    @textbooks = Textbook.all().as_json

    @real_textbooks = @textbooks.map do |textbook|
      textbook["textbook_title"] = Book.find(textbook["book_id"]).title
    end

    puts @real_textbooks

    render :json => @textbooks
  end

  def show
    @special_textbook = @textbook.as_json rescue nil

    if @textbook then
      @textbook["textbook_title"] = Book.find(@textbook["book_id"]).title
      render :json => @textbook
    else
      render :json => {status: 404}
    end

  end

  def create
    @new_textbook = Textbook.new(textbook_params)

    if @new_textbook.save
      render json: @new_textbook, status: :created
    else
      render json: error_message
    end


  end

  def update

    if @textbook.update_attributes(textbook_params)
      render json: @textbook, status: :updated
    else
      render json: error_message
    end

  end

  def destroy

    if @textbook.destroy
      render json: {"status": "Destroyed Textbook"}, status: :deleted
    else
      render json: error_message
    end

  end


  private

    def set_textbook
      @textbook = Textbook.find(params[:id])
    end

    def textbook_params
      params.require(:textbook).permit(:book_id, :user_id, :status, :owner_description, :is_public)
    end

    def error_message
      {"status": "unable to do specified action"}
    end

end
