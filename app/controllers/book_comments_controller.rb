class BookCommentsController < ApplicationController
  before_action :is_matching_login_user, only: [:destroy]

def create
  book = Book.find(params[:book_id])
  @comment = BookComment.new(book_comment_params)
  @comment.user_id = current_user.id
  @comment.book_id = book.id
  if @comment.save
    redirect_back fallback_location: user_path(current_user.id)
  else
    # @comment = BookComment.new(book_comment_params)
    @book = Book.find(params[:book_id])
    @user = @book.user
    @book_new = Book.new
    render 'books/show'
    # redirect_to book_path(@book.id)
  end
end 

def destroy
  BookComment.find(params[:id]).destroy
  redirect_to book_path(params[:book_id])
end  

private

def book_comment_params
  params.require(:book_comment).permit(:comment)
end

def is_matching_login_user
  bookcomment = BookComment.find(params[:id])
  user = bookcomment.user
  unless user.id == current_user.id
    redirect_to book_path(params[:book_id])
  end
end

end

