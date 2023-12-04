# Table "public.likes"
# Column   |              Type              | Collation | Nullable |              Default
# ------------+--------------------------------+-----------+----------+-----------------------------------
# id         | bigint                         |           | not null | nextval('likes_id_seq'::regclass)
# user_id    | bigint                         |           | not null |
# post_id    | bigint                         |           | not null |
# created_at | timestamp(6) without time zone |           | not null |
# updated_at | timestamp(6) without time zone |           | not null |
# Indexes:
#  "likes_pkey" PRIMARY KEY, btree (id)
#  "index_likes_on_post_id" btree (post_id)
#  "index_likes_on_user_id" btree (user_id)
# Foreign-key constraints:
#  "fk_rails_1e09b5dabf" FOREIGN KEY (user_id) REFERENCES users(id)
#  "fk_rails_87a8aac469" FOREIGN KEY (post_id) REFERENCES posts(id)
class Like < ApplicationRecord
  belongs_to :post
  belongs_to :user

  after_create :increment_likes_counter
  after_destroy :decrement_likes_counter

  private

  def increment_likes_counter
    post.increment!(:likes_counter)
  end

  def decrement_likes_counter
    post.decrement!(:likes_counter)
  end
end
