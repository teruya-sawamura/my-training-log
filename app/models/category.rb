class Category < ApplicationRecord
  has_many :trainings
  validates :name, presence: true, length: { maximum: 25 }
end
