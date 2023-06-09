class NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end
  
  def destroy
    if params[:id].present?
    @notification = Notification.find(params[:id]).destroy
    else
    @notifications = current_user.passive_notifications.destroy_all
    end
    redirect_to notifications_path
  end
end
