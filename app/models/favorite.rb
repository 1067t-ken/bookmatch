class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :book
end

# == Schema Information
#
# Table name: favorites
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  book_id    :integer
#  user_id    :integer
#
