class BookCommentsController < ApplicationController
  before_action :is_matching_login_user, only: [:destroy]

def create
  book = Book.find(params[:book_id])
  comment = current_user.book_comments.new(book_comment_params)
  comment.book_id = book.id
  comment.save
  redirect_to book_path(book)
  
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
