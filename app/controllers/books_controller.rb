class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:update,:edit]

  def show

    @book = Book.find(params[:id])
    @user = @book.user
    @book_new = Book.new
    @comment = BookComment.new
    @book_tags = @book.tags    
    @tag_list = Tag.all
    @currentUserEntry = Entry.where(user_id: current_user.id)
    @userEntry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @currentUserEntry.each do |cue|
        @userEntry.each do |ue|
          if cue.room_id == ue.room_id then
            @isRoom = true
            @chatroom = cue.room_id
          else
            @room = Room.new
            @entry = Entry.new
          end            
        end
      end
    end
  end

  def index

    if params[:sort]
      selection = params[:sort]
      if selection == "favorite_count"
        books = Book.includes(:favorited_users).sort_by {|x|
          x.favorited_users.includes(:favorites).size
        }.reverse
        @books = Kaminari.paginate_array(books).page(params[:page])
      else
      @books = Book.sort(selection).page(params[:page])
      end
    else
      to = Time.current.at_end_of_day
      from = (to - 7.day).at_beginning_of_day
      books = Book.includes(:favorited_users).
        sort_by {|x|
          x.favorited_users.includes(:favorites).where(created_at: from...to).size
        }.reverse
        @books = Kaminari.paginate_array(books).page(params[:page])
    end
    @book = Book.new

  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    tag_list=params[:book][:name].split("/")
    if @book.save
      @book.save_tag(tag_list)
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    @tags = @book.tags.pluck(:name).join('/')
  end

  def update
    @book = Book.find(params[:id])
    tag_list = params[:book][:name].split("/")
    if @book.update(book_params)
      @book.save_tag(tag_list)
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

