# == Schema Information
#
# Table name: books
#
#  id         :integer          not null, primary key
#  isbn       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_books_on_isbn  (isbn)
#
require "test_helper"

class BookTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
