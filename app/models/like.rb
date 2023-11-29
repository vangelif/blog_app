class Like < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: 'User'

  def update_counter
    post.update(likes_counter: post.likes.count)
  end
end
