class MessagesController < ApplicationController
  
  def create
      @room = Room.find(params[:message][:room_id])
      @messages = @room.messages
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.create(params.require(:message).permit(:user_id, :comment, :room_id).merge(user_id: current_user.id))
    end
  end
end
