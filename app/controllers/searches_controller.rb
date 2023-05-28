class SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def search
    @book = Book.new
    @tag_list = Tag.all  
    @range = params[:range]
    if @range == "User"
      @users = User.looks(params[:search],params[:word])
    elsif @range == "Book"
      @books = Book.looks(params[:search],params[:word])
    elsif @range == "tag"
      @books = Tag.looks(params[:search],params[:word])
    end
    
  end
  
end

