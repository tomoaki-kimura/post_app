class Picture < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { maximum: 20 }
  validates :description, allow_blank: true, length: { minimum: 5, maximum: 300 }
end
