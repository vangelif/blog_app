require 'rails_helper'

RSpec.describe 'Posts#index', type: :system do
  before(:all) do
    # need to make capybara setup to run system tests
    driven_by(:rack_test)
    # need to create users, posts, and comments
    Comment.delete_all
    Post.delete_all
    User.delete_all

    def url_for_image
      'https://images.unsplash.com/photo-1552058544-f2b08422138a?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OTZ8fHBvcnRyYWl0fGVufDB8fDB8fHww'
    end

    @tom = User.create(name: 'Tom', photo: url_for_image, bio: 'Teacher from Mexico.',

                       posts_counter: 0)
    @first_post = Post.create(author: @tom, title: 'Hello', text: 'This is my first post', comments_counter: 0,
                              likes_counter: 0)
    @lilly = User.create(name: 'Lilly', photo: url_for_image, bio: 'Teacher from Poland.',
                         posts_counter: 0)
    @second_post = Post.create(author: @lilly, title: 'Hi World!', text: 'Lets talk', comments_counter: 0,
                               likes_counter: 0)
    Comment.create(post: @first_post, user: @lilly, text: 'Hi Tom!')
    Comment.create(post: @second_post, user: @tom, text: 'Hi Lilly!')
    @users = User.all
    @posts = Post.all
  end

  #   I can see the user's profile picture.
  it 'displays the user profile picture' do
    visit '/users'
    click_on 'Lilly'
    expect(page).to have_css("img[src*='https://images.unsplash.com/photo-1552058544-f2b08422138a?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OTZ8fHBvcnRyYWl0fGVufDB8fDB8fHww']")
  end
  #   I can see the user's username.
  it 'displays the user username' do
    visit '/users'
    click_on 'Lilly'
    expect(page).to have_content('Lilly')
  end
  #   I can see the number of posts the user has written.
  it 'displays the number of posts the user has written' do
    visit '/users'
    click_on 'Lilly'
    expect(page).to have_content('1')
  end

  #   I can see a post's title.
  it 'displays the post title' do
    visit user_posts_path(@lilly)
    expect(page).to have_content('World!')
  end

  #   I can see some of the post's body.
  it 'displays the post body' do
    visit user_posts_path(@lilly)
    expect(page).to have_content('Lets talk')
  end

  # #   I can see the first comments on a post.
  it 'displays the first comment on a post' do
    visit user_posts_path(@tom)
    expect(page).to have_content('first post')
  end

  # #   I can see how many comments a post has.
  it 'displays the number of comments a post has' do
    visit user_posts_path(@tom)
    expect(page).to have_content('1')
  end

  #   I can see how many likes a post has.
  it 'displays the number of likes a post has' do
    visit user_posts_path(@tom)
    expect(page).to have_content('0')
  end

  #   I can see a section for pagination if there are more posts than fit on the view.
  it 'displays a section for pagination if there are more posts than fit on the view' do
    visit user_posts_path(@tom)
    expect(page).to have_content('1')
    visit user_posts_path(@lilly)
    expect(page).to have_content('1')
  end

  #   When I click on a post, it redirects me to that post's show page.
  it 'redirects to the post show page' do
    visit user_posts_path(@tom)
    click_on 'first post'
    expect(page).to have_content('first post')
  end
end
