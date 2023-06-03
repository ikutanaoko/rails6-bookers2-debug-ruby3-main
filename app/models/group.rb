class Group < ApplicationRecord
  has_many :user_groups
  has_many :users, through: :user_groups
  
  has_one_attached :group_image
  
  def get_group_image(width, heigh)
    unless group_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      group_image.attach(io: File.open(file_path), filename: 'default-image-jpg', content_type: 'image/jpeg')
    end
    group_image.variant(resize_to_limit: [width, heigh]).processed
  end
  
  valitates :name, presence: true
  valitates :introduction, presence: true , length: { maximum: 500 }
end
