class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  
  validates :comment, presence: true, length: { maximum: 140 }
  
end

