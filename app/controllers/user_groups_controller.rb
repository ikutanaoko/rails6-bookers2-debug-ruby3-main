class UserGroupsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @user = current_user
    @book = Book.new
    @groups = @user.groups
  end
    

  def create
    user_group = current_user.user_groups.new(group_id: params[:group_id])
    user_group.save
    redirect_to request.referer
  end
  
  def destroy
    user_group = current_user.user_groups.find_by(group_id: params[:group_id])
    user_group.destroy
    redirect_to request.referer
  end
end
