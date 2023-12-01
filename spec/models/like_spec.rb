require 'rails_helper'
RSpec.describe Like, type: :model do
  let(:user) { User.create(name: 'Casper', photo: 'https://portraits/', bio: 'I am teacher from Mars') }
  let(:post) { Post.create(author: user, title: 'Hey World', text: 'Hi Casper!') }
  subject { Like.create(user:, post:) }
  before { subject.save }

  it 'check validity of user presence' do
    subject.user = nil
    expect(subject).to_not be_valid
  end
  it 'check validity of post presence' do
    subject.post = nil
    expect(subject).to_not be_valid
  end
  it 'check likes_counter equal to 1' do
    expect(post.likes_counter).to eq(1)
  end
  it 'check likes_counter equal to 0 after destroying it' do
    subject.destroy
    expect(post.likes_counter).to eq(0)
  end
end
