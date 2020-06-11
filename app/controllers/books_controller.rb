class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_user, only: [:edit, :update, :destroy]

  def index
  	@book = Book.new
  	@books = Book.all
  end

  def show
  	@book = Book.find(params[:id])
    @new_book = Book.new
    @user = @book.user
  end

  def edit
  	@book = Book.find(params[:id])
  end

  def create
  	@book = Book.new(book_params)
  	@book.user_id = current_user.id
  	if @book.save
       flash[:notice] = "You have creatad book successfully."
  		 redirect_to @book
    else
        @books = Book.all
        render :index
    end
  end

  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
       flash[:notice] = "You have updated book successfully."
  		 redirect_to @book
  	else
  		 render :edit
  	end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    flash[:notice] = "You have successfully delete book."
    redirect_to books_path
  end

  private
  def book_params
      params.require(:book).permit(:title,:body)
  end

  def ensure_user
    @book = Book.find(params[:id])
    return if @book.user_id == current_user.id
    redirect_to books_path
  end

end
