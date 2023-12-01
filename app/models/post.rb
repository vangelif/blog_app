class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  after_create :increment_users_counter
  after_destroy :decrement_users_counter

  def five_most_recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  private

  def increment_users_counter
    author.increment!(:posts_counter)
  end

  def decrement_users_counter
    author.decrement!(:posts_counter)
  end
end
