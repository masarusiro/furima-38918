class OrdersController < ApplicationController
    def index
      @order_destinations = OrderDestinations.new
      @item = Item.find(params[:item_id])
    end

    def create
      @item = Item.find(params[:item_id])
      @order_destinations = OrderDestinations.new(order_params)
      if @order_destinations.valid?
         @order_destinations.save
         redirect_to root_path
      else
         render :index
      end
    end

private

def order_params
  params.require(:order_destinations).permit(:postcode, :prefecture_id, :city, :block, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
end

end