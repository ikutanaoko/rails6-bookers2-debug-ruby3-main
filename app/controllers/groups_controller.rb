class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update]

  def index
    @book = Book.new
    @groups = Group.all
  end

  def show
    @book = Book.new
    @group = Group.find(params[:id])
  end
  
  def new
    @group = Group.new
  end
  
  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      redirect_to groups_path
    else
      render 'new'
    end
  end

  def edit
    @group = Group.find(params[:id])
  end
  
  def update
    if @group.update(group_params)
      redirect_to group_path
    else
      render "edit"
    end
  end
  
  private
  
  def group_params
    params.require(:group).permit(:name, :introduction, :image)
  end
  
  def is_matching_login_user
    bookcomment = BookComment.find(params[:id])
    user = bookcomment.user
    unless user.id == current_user.id
      redirect_to book_path(params[:book_id])
    end
  end
  
end
