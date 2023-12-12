require 'rails_helper'

RSpec.describe 'Users#index', type: :system do
    before(:all) do
        User.destroy_all
        Post.destroy_all
        Comment.destroy_all
        
    @lilly = User.create!(name: 'Lilly', photo: 'https://portraits.ai', bio: '', posts_counter: 0)
    Post.create!(title: 'First Post', text: 'This is my first post', author: @lilly, comments_counter: 0, likes_counter: 0)
    @tom = User.create!(name: 'Tom', photo: 'https://portraits.ai', bio: '', posts_counter: 0)
    @users = User.all
end 

it 'displays the names of all users' do
    visit '/users'
    @users.each do |user|
        expect(page).to have_content(user.name)
    end
end

it 'displays the names of specific users' do
    visit '/users'
    expect(page).to have_content('Lilly')
    expect(page).to have_content('Tom')
    end
end