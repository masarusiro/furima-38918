class OrderDestinations
  include ActiveModel::Model

   with_options presense: true do
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