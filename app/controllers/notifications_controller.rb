class NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end
  
  def destroy
    notification = Notification.find(params[:id]).destroy

  end
  
  def destroy_all
    current_user.passive_notifications.destroy_all
    redirect_to notifications_path
  end

end