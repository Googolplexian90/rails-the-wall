class Message < ActiveRecord::Base
  belongs_to :user
  has_many :comments, as: :parent
  validates :post,:user, presence:true
end
