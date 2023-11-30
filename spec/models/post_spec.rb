# Title must not be blank.
# Title must not exceed 250 characters.
# CommentsCounter must be an integer greater than or equal to zero.
# LikesCounter must be an integer greater than or equal to zero.
require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    it 'title must not be blank' do
      post = Post.new(title: nil)
      expect(post).to_not be_valid
    end

    it 'title must not exceed 250 characters' do
      post = Post.new(title: 'a' * 251)
      post.valid?
      expect(post.errors[:title]).to include("it's too long! -- maximum 250 characters")

      post.title = 'a' * 250
      post.valid?
      expect(post.errors[:title]).to be_empty
    end

    it 'CommentsCounter must be an integer and greater than or equal to zero' do
      post = Post.new(comments_counter: 'not_an_integer')
      post.valid?
      expect(post.errors[:comments_counter]).to include('must be an integer!')

      post.comments_counter = -1
      post.valid?
      expect(post.errors[:comments_counter]).to include('must be greater or equal to 0')

      post.comments_counter = 5
      post.valid?
      expect(post.errors[:comments_counter]).to be_empty
    end

    it 'LikesCounter must be an integer and greater than or equal to zero' do
      post = Post.new(likes_counter: 'not_an_integer')
      post.valid?
      expect(post.errors[:likes_counter]).to include('must be an integer!')

      post.likes_counter = -1
      post.valid?
      expect(post.errors[:likes_counter]).to include('must be greater than or equal to 0')

      post.likes_counter = 5
      post.valid?
      expect(post.errors[:likes_counter]).to be_empty
    end
  end
end
