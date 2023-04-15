class Item < ApplicationRecord



  
  belongs_to :user
  has_one_sttached :image

  #ActiveHash
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :prefecture
  belongs_to :condition
  belongs_to :shipping_cost
  belongs_to :shipping_day
end
