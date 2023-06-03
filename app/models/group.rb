class Group < ApplicationRecord
  has_many :user_groups, dependent: :destroy
  has_many :users, through: :user_groups, source: :user
  
  has_one_attached :group_image
  
  def get_group_image(width, heigh)
    unless group_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      group_image.attach(io: File.open(file_path), filename: 'default-image-jpg', content_type: 'image/jpeg')
    end
    group_image.variant(resize_to_limit: [width, heigh]).processed
  end
  
  def includeUser?(user)
    user_groups.exists?(user_id: user.id)
  end
  validates :name, presence: true
  validates :introduction, presence: true , length: { maximum: 500 }
end
