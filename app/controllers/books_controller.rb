# Controller in charge of handling book related api requests

class BooksController < ApplicationController

  # Apply authentication to every api request excluding ones dealing with reading from the db
  skip_before_action :authenticate_request, only: [:index, :show]

  # Retrieve the book parameters from the api request when viewing, updating, or destroying a specific book
  before_action :set_book, only: [:show, :update, :destroy]

  # Renders all the books to client
  def index
    @books = Book.all()
    render :json => @books
  end

  # Renders a specific book to a client by the book_id
  def show
    render :json => @book
  end

  # Creates a new book based off the book params specified
  def create
    @new_book = Book.new(book_params)

    # Checks if the book already exists in db by searching via ISBN#
    @existing_book = Book.find_by(ISBN: @new_book.ISBN)

    if @existing_book then
      render json: error_message
    else #If it is a new unique book then we can go ahead and save it
      if @new_book.save
        render json: @new_book, status: :created
      else
        render json: error_message
      end
    end

  end

  # Destroys a book based off the book_id
  def destroy

    if @book.destroy
      render json: {"status": "Destroyed book"}, status: :ok
    else
      render json: error_message
    end

  end

  # Updates a book based off the book_id by updating the book's attributes
  def update

    if @book.update_attributes(book_params)
      render json: @book, status: :ok
    else
      render json: error_message
    end

  end

  private

    # default error message
    def error_message
      {"status": "unable to do specified action"}
    end

    # Book variable for updating, viewing, and deleting a specific book

    def set_book
      @book = Book.find(params[:id]) rescue nil

      if @book == nil
        render json: {"status": "book does not exist"}
      end

    end

    # Book fields as retrieved from book api requests
    def book_params
      params.require(:book).permit(:ISBN, :title, :description, :manufacturer_id, :cover_image_link)
    end


end
