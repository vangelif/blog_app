# Table "public.posts"
# Column      |              Type              | Collation | Nullable |              Default
# ------------------+--------------------------------+-----------+----------+-----------------------------------
# id               | bigint                         |           | not null | nextval('posts_id_seq'::regclass)
# title            | character varying              |           |          |
# text             | text                           |           |          |
# comments_counter | integer                        |           |          | 0
# likes_counter    | integer                        |           |          | 0
# author_id        | bigint                         |           | not null |
# created_at       | timestamp(6) without time zone |           | not null |
# updated_at       | timestamp(6) without time zone |           | not null |
# Indexes:
# "posts_pkey" PRIMARY KEY, btree (id)
# "index_posts_on_author_id" btree (author_id)
# Foreign-key constraints:
# "fk_rails_5b5ddfd518" FOREIGN KEY (author_id) REFERENCES users(id)
# Referenced by:
# TABLE "comments" CONSTRAINT "fk_rails_2fd19c0db7" FOREIGN KEY (post_id) REFERENCES posts(id)
# TABLE "likes" CONSTRAINT "fk_rails_87a8aac469" FOREIGN KEY (post_id) REFERENCES posts(id)

class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  # these are callbacks that will be executed 
  # by calling the private methods 
  # when a new post is created or destroyed
  after_create :increment_users_counter
  after_destroy :decrement_users_counter

  def five_most_recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  private

  def increment_users_counter
    # increment! is an ActiveRecord method
    # for increasing the value of an attribute by 1
    # :posts_counter is an attribute on User's table
    author.increment!(:posts_counter)
  end

  def decrement_users_counter
        # decrement! is an ActiveRecord method
    # for decreasing the value of an attribute by 1
    # :posts_counter is an attribute on User's table
    author.decrement!(:posts_counter)
  end
end
