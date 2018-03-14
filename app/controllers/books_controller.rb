class BooksController < ApplicationController

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

    if @new_book.save
      render json: @new_book, status: :created
    else
      render json: error_message
    end

  end

  def destroy

    if @book.destroy
      render json: {"status": "Destroyed book"}, status: :deleted
    else
      render json: error_message
    end

  end

  def update

    if @book.update_attributes(book_params)
      render json: @book, status: :updated
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
      params.require(:book).permit(:ISBN, :title, :description, :manufacturer_id)
    end


end
