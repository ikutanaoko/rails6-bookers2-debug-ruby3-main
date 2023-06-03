class UserGroupsController < ApplicationController
  before_action :authenticate_user!
  
  def ceate
    user_group = current_user.user_group.new(group_id: params[:group_id])
    user_group.save
    redirect_to request.referer
  end
  
  def destroy
    user_group = current_user.user_gtoups.find_by(group_id: params[:group_id])
    user_group.destroy
    redirect_to request.referer
  end
end
