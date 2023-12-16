class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :bio, :email
  has_many :posts
  has_many :comments
end
