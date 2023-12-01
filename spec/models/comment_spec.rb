require 'rails_helper'
RSpec.describe Comment, type: :model do
  let(:user_one) { User.create(name: 'Tom', photo: 'https://pics/', bio: 'Teacher from Wisconsin.') }
  let(:user) { User.create(name: 'Smith', photo: 'https://example.com', bio: 'Ola como coca cola.') }
  let(:post_one) { Post.create(author: user, title: 'hey', text: 'how is life?!') }
  subject { Comment.create(post: post_one, user: user_one, text: 'all good!') }
  before { subject.save }
  it 'check post presence' do
    subject.post = nil
    expect(subject).to_not be_valid
  end
  it 'check user presence' do
    subject.user = nil
    expect(subject).to_not be_valid
  end
  it 'check comments_counter equal to 1' do
    expect(post_one.comments_counter).to eq(1)
  end
  it 'check likes_counter equal to 1' do
    expect(post_one.likes_counter).to eq(0)
  end
end
