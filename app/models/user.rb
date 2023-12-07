# ---------------+--------------------------------+-----------+----------+-----------------------------------
#  id            | bigint                         |           | not null | nextval('users_id_seq'::regclass)
#  name          | character varying              |           |          |
#  photo         | character varying              |           |          |
#  bio           | text                           |           |          |
#  posts_counter | integer                        |           |          | 0
#  created_at    | timestamp(6) without time zone |           | not null |
#  updated_at    | timestamp(6) without time zone |           | not null |
# Indexes:
#     "users_pkey" PRIMARY KEY, btree (id)
# Referenced by:
#     TABLE "comments" CONSTRAINT "fk_rails_03de2dc08c" FOREIGN KEY (user_id) REFERENCES users(id)
#     TABLE "likes" CONSTRAINT "fk_rails_1e09b5dabf" FOREIGN KEY (user_id) REFERENCES users(id)
#     TABLE "posts" CONSTRAINT "fk_rails_5b5ddfd518" FOREIGN KEY (author_id) REFERENCES users(id)

class User < ApplicationRecord
  # the user has many posts and the the foreign key in the posts is author_id
  # when the user is deleted the dependent: :destroy option ensures that all posts
  # are also destroyed
  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  def three_most_recents_posts
    posts.order(created_at: :desc).limit(3)
  end

  def has_posts?
    three_most_recents_posts.present?
  end

  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
