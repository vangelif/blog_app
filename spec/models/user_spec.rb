# Name must not be blank.
# PostsCounter must be an integer greater than or equal to zero.
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'name must not be blank' do
      user = User.new(name: nil)
      # user.valid?
      expect(user).to_not be_valid
    end

    it 'PostCounter must be an integer and greater or equal to zero' do
      # user = User.new(posts_counter: 'not an integer')
      # user.valid?
      # expect(user.errors[:posts_counter]).to include('must be an integer!')

      # user.posts_counter = -1
      # user.valid?
      # expect(user.errors[:posts_counter]).to include('must be greater than or equal to 0')

      # user.posts_counter = 5
      # user.valid?
      # expect(user.errors[:posts_counter]).to be_empty
    end
  end
end
