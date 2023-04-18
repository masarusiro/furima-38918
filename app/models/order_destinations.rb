class OrderDestinations
  include ActiveModel::Model

   with_options presence: true do
    #orderモデル
    validates :user_id
    validates :item_id
    #destinationモデル
    validates :postcode
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city
    validates :block
    validates :phone_number
   end

   def save
    #購入者と商品を代入
    order = Order.create(user_id: user_id, item_id: item_id)
    #order.idは上でorderのid   
    Destination.create(postcode: postcode, prefecture_id: prefecture_id, city: city, block: block, building: building, phone_number: phone_number, order_id: order.id)
   end

  end