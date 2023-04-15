class Item < ApplicationRecord


  validates :name, presense: true
  validates :description, presense: true
  validates :category_id, numericality: { other_than: 1, message: "can't be blank"}
  validates :condition_id, numericality: { other_than: 1, message: "can't be blank"}
  validates :shipping_cost_id, numericality: { other_than: 1, message: "can't be blank"}
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank"}
  validates :shipping_day_id, numericality: { other_than: 1, message: "can't be blank"}
  validates :price, presense: true, numericality: {only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999}
  validates :user_id, presense:true
  validates :image, presense:true
  
  #modelとのアソシエーション
  belongs_to :user
  has_one_sttached :image

  #ActiveHashを使ったモデルとのアソシエーション
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :prefecture
  belongs_to :condition
  belongs_to :shipping_cost
  belongs_to :shipping_day
end
