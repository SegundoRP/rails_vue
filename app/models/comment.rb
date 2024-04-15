class Comment < ApplicationRecord
  belongs_to :feature, class_name: 'Earthquake'

  validates :body, presence: true
end
