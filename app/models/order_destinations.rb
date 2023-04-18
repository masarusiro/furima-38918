class OrderDestinations
  include ActiveModel::Model

   with_options presense: true do
    validates :user_id
    validates :item_id

    
  
  end