# Model to represent an article written by a golfer
# - title: title of the article
# - description: content of the article
class Article < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { minimum: 3 }
  validates :description, presence: true, length: { minimum: 3 }

  def serialize
    {
      id: id,
      title: title,
      description: description,
      user_name: user.name,
      created_at: created_at
    }
  end
end
