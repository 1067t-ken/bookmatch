class Tag < ApplicationRecord
  has_many :book_tags, dependent: :destroy
  has_many :books, through: :book_tags
  
  validates :name, presence:true, length:{maximum:20}
end

# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_tags_on_name  (name) UNIQUE
#
