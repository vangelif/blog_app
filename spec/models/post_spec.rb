require 'rails_helper'

describe Post, type: :model do
  let(:user) do
    User.create(name: 'Jonathan',
                photo: 'https://unsplash.com/photos/man-in-white-crew-neck-t-shirt-kissing-woman-in-white-dress-Z39a7lqZusU', bio: 'I love my job')
  end


  subject { Post.create(author: user, title: 'This is a post title!', text: 'My first post is about rails framework!') }
  before { subject.save }
  describe 'Post validations' do
    it 'User should be present' do
      subject.author = nil
      expect(subject).to_not be_valid
    end
    # Title must not be blank.
    it 'title must not be blank' do
      post = Post.new(title: nil)
      expect(post).to_not be_valid
    end
    # Title must not exceed 250 characters.
    it 'title must not exceed 250 characters' do
      post = Post.new(title: 'a' * 251)
      expect(post).to be_invalid
      expect(post.errors[:title]).to include('is too long (maximum is 250 characters)')
    end
    # CommentsCounter must be an integer.
    it 'comments_counter must be an integer' do
      subject.comments_counter = 'apples'
      expect(subject).to_not be_valid
    end

    # CommentsCounter must be greater than or equal to zero.
    it 'comments_counter and likes_counter should be equal to zero' do
      subject.comments_counter = 0
      subject.likes_counter = 0
      expect(subject).to be_valid
    end
    # LikesCounter must be an integer.
    it 'likes_counter must be an integer' do
      subject.likes_counter = 'bananas'
      expect(subject).to_not be_valid
    end

    # LikesCounter must be greater than or equal to zero.
    it 'comments_counter and likes_counter should be greater than zero' do
      subject.comments_counter = -5
      expect(subject).to_not be_valid
      subject.likes_counter = -5
      expect(subject).to_not be_valid
    end

    it 'check posts_counter to equal 1' do
      expect(user.posts_counter).to eq(1)
    end


    it 'returns an empty array when there are no comments' do
      result = subject.five_most_recent_comments
      expect(result).to be_empty
    end
  end
end
