class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  validates :star,presence:true
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  def self.sort(selection)
    case selection
    when "latest"
      return all.order(created_at: :desc)
    when "old"
      return all.order(created_at: :asc)
    when "star_count"
      return all.order(star: :desc)
    end
  end
  
  # scope :latest, -> {order(created_at: :desc)}
  # scope :old, -> {order(created_at: :asc)}
  # scope :star_count, -> {order(star: :desc)}
  
  def self.looks(search, word)
    if search == "perfect_match"
      @book = Book.where("title LIKE?", "#{word}")
    elsif search == "forward_match"
      @book = Book.where("title LIKE?", "#{word}%")
    elsif search == "backward_match"
      @book = Book.where("title LIKE?", "%#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE?", "%#{word}%")
    else
      @book = Book.all
    end
  end
  
end
