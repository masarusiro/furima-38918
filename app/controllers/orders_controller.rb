class OrdersController < ApplicationController
  before_action :authenticate_user!
  

    def index
      @order_destinations = OrderDestinations.new
      @item = Item.find(params[:item_id])
    end

    def create
      @item = Item.find(params[:item_id])
      @order_destinations = OrderDestinations.new(order_params)
      if @order_destinations.valid?
         pay_item
         @order_destinations.save
         redirect_to root_path
      else
         render :index
      end
    end

private

def order_params
  params.require(:order_destinations).permit(:postcode, :prefecture_id, :city, :block, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
end

def pay_item
  Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  # PAY.JPテスト秘密鍵
  Payjp::Charge.create(
    amount: @item.price,  # 商品の値段
    card: order_params[:token],    # カードトークン
    currency: 'jpy'                 # 通貨の種類（日本円）
  )
end  


end