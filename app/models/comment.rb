# Table "public.comments"
# Column   |              Type              | Collation | Nullable |               Default
# ------------+--------------------------------+-----------+----------+--------------------------------------
# id         | bigint                         |           | not null | nextval('comments_id_seq'::regclass)
# text       | text                           |           |          |
# user_id    | bigint                         |           | not null |
# post_id    | bigint                         |           | not null |
# created_at | timestamp(6) without time zone |           | not null |
# updated_at | timestamp(6) without time zone |           | not null |
# Indexes:
#  "comments_pkey" PRIMARY KEY, btree (id)
#  "index_comments_on_post_id" btree (post_id)
#  "index_comments_on_user_id" btree (user_id)
# Foreign-key constraints:
#  "fk_rails_03de2dc08c" FOREIGN KEY (user_id) REFERENCES users(id)
#  "fk_rails_2fd19c0db7" FOREIGN KEY (post_id) REFERENCES posts(id)

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :user, presence: true
  validates :text, presence: true

  after_create :increment_comments_counter
  after_destroy :decrement_comments_counter

  private

  def increment_comments_counter
    post.increment!(:comments_counter)
  end

  def decrement_comments_counter
    post.decrement!(:comments_counter)
  end
end
