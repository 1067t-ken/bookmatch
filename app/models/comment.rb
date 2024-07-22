class Comment < ApplicationRecord
  belongs_to :review
  belongs_to :user
end

# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  review_id  :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_comments_on_review_id  (review_id)
#  index_comments_on_user_id    (user_id)
#
# Foreign Keys
#
#  review_id  (review_id => reviews.id)
#  user_id    (user_id => users.id)
#
