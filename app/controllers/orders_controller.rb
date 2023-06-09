class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :check_access, only: [:index, :create]

  def index
    @order_destinations = OrderDestinations.new
  end

  def create
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
    params.require(:order_destinations).permit(:postcode, :prefecture_id, :city, :block, :building, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY'] # PAY.JPテスト秘密鍵
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      card: order_params[:token], # カードトークン
      currency: 'jpy' # 通貨の種類（日本円）
    )
  end

  def check_access
    @item = Item.find(params[:item_id])
    redirect_to root_path if current_user.id == @item.user_id || @item.order.present?
  end
end
