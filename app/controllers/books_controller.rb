class BooksController < ApplicationController

  skip_before_action :authenticate_request, only: [:index, :show]
  before_action :set_book, only: [:show, :update, :destroy]

  def index
    @books = Book.all()
    render :json => @books
  end

  def show
    render :json => @book
  end

  def create
    @new_book = Book.new(book_params)

    @existing_book = Book.find_by(ISBN: @new_book.ISBN)

    if @existing_book then
      render json: error_message
    else
      if @new_book.save
        render json: @new_book, status: :created
      else
        render json: error_message
      end
    end

  end

  def destroy

    if @book.destroy
      render json: {"status": "Destroyed book"}, status: :ok
    else
      render json: error_message
    end

  end

  def update

    if @book.update_attributes(book_params)
      render json: @book, status: :ok
    else
      render json: error_message
    end

  end

  private

    def error_message
      {"status": "unable to do specified action"}
    end

    def set_book
      @book = Book.find(params[:id]) rescue nil

      if @book == nil
        render json: {"status": "book does not exist"}
      end

    end

    def book_params
      params.require(:book).permit(:ISBN, :title, :description, :manufacturer_id, :cover_image_link)
    end


end
