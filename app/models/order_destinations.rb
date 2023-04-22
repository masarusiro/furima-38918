class OrderDestinations
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postcode, :prefecture_id, :city, :block, :building, :phone_number, :token
   with_options presence: true do
    #orderモデル
    validates :user_id
    validates :item_id
    #destinationモデル
    validates :postcode, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city
    validates :block
    validates :phone_number, format: { with: /\A[0-9]{11}\z/, message: 'is invalid' }
    #payjp トークン
    validates :token
   end

   def save
    #購入者と商品を代入
    order = Order.create(user_id: user_id, item_id: item_id)
    #order.idは上でorderのid   
    Destination.create(postcode: postcode, prefecture_id: prefecture_id, city: city, block: block, building: building, phone_number: phone_number, order_id: order.id)
   end

  end 
  
