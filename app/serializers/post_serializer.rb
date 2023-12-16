class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :text, :author_id, :comments_counter, :likes_counter
  has_many :comments
  belongs_to :author
end
