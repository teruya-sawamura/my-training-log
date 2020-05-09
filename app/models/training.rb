class Training < ApplicationRecord
  belongs_to :category
  validates :content, presence: true, length: { maximum: 25 }
  validates :time, presence: true
  
  ransacker :created_at, callable: proc { Arel.sql('DATE(created_at)') }
end
