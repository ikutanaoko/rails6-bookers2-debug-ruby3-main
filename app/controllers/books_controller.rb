class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:update,:edit]

  def show

    @book = Book.find(params[:id])
    @user = @book.user
    @book_new = Book.new
    @comment = BookComment.new
    
    
  end

  def index
    if params[:sort]
      selection = params[:sort]
      @books = Book.sort(selection)
    else
      @books = Book.all
    end
    @book = Book.new

  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :star)
  end

  def is_matching_login_user
    book = Book.find(params[:id])
    user = book.user
    unless user.id == current_user.id
      redirect_to books_path
    end
  end  
end
