class Review < ApplicationRecord
  belongs_to :user
  belongs_to :post 
  validates :user_id, presence: true
  validates :post_id, presence: true
  validates :comment, presence: true
  validates :rating, presence: true , numericality: { only_integer: true , greater_than_or_equal_to: 1 , less_than_or_equal_to: 5 }
end
