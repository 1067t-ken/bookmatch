class Book < ApplicationRecord
  attribute :tags_to_s, :string
  
  has_many :book_tags, dependent: :destroy
  has_many :tags, through: :book_tags
  
  has_many :favorites
  has_many :reviews, dependent: :destroy
  validates :isbn, presence: true
  
  after_save :tags_update
  after_find :tags_to_form_value
  
  def favorited_by?(user)
    Favorite.find_by(book_id: self.id, user_id: user.id)
  end
  
  private
  
  def tags_update
    form_tags = self&.tags_to_s&.split(/[[:space:]]/)&.uniq&.compact&.reject(&:empty?) || []
    database_tags = self.tags.pluck(:name)
    new_tags = form_tags - database_tags
    new_tags.each do |name|
      tag = Tag.find_or_create_by(name: name)
      self.book_tags.find_or_create_by(tag_id: tag.id)
    end
    delete_tags = database_tags - form_tags
    delete_tags.each do |name|
      tag = Tag.find_by(name: name)
      book_tags = self.book_tags
      book_tag = book_tags.find_by(tag_id: tag.id)
      tag.destroy if book_tags.size <= 1
      book_tag.destroy if book_tag
    end
  end
  
  def tags_to_form_value
    tags = self.tags.pluck(:name)
    self.tags_to_s = tags.join(' ')
    self
  end
end

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
