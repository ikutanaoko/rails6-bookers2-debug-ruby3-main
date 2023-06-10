class Room < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :notifications, dependent: :destroy

  def create_notification_message(current_user)
    @multiple_entry_records = Entry.where(room_id: id).where.not(user_id: current_user.id)
    @single_entry_record = @multiple_entry_records.find_by(room_id: id)
    notification = current_user.active_notifications.new(
      room_id: id,
      visited_id: @single_entry_record.user_id,
      action: 'message'
      )
    # if notification.visitor_id == notification.visited_id
    #   notification.checked = true
    # end
    if notification.valid?
    notification.save
    end
  end

end
