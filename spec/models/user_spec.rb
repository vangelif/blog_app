require 'rails_helper'

RSpec.describe User, type: :model do
  # subject is an instance of 'User'
  subject { User.new(id: 1, name: 'Jeremy') }
  # before block ensures that this user is saved to the db
  # before each test within the example group
  before { subject.save }
  describe 'User validations' do
    # Name must not be blank.
    it 'name must not be blank' do
      user = User.new(name: nil)
      expect(user).to_not be_valid
    end
    # PostsCounter must be an integer.
    it 'posts_counter should be integer' do
      subject.posts_counter = 'chickens'
      expect(subject).to_not be_valid
    end
    # PostsCounter must be greater than or equal to zero.
    it 'posts_counter should be greater than or equal to zero' do
      subject.posts_counter = 0
      expect(subject).to be_valid
      subject.posts_counter = -5
      expect(subject).to_not be_valid
    end

    it 'returns no more than three posts' do
      expect(subject.three_most_recents_posts.length).to be <= 3
    end
  end
end
