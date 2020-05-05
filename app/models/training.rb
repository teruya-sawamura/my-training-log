class Training < ApplicationRecord
  belongs_to :category
  validates :content, presence: true, length: { maximum: 25 }
  validates :time, presence: true
end
