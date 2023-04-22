require 'rails_helper'

RSpec.describe OrderDestinations, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order_destinations = FactoryBot.build(:order_destinations, user_id: @user.id, item_id: @item.id)
    sleep 0.1
  end
  context '商品購入ができる時' do
    it '全ての項目が入力されていれば購入ができる' do
      expect(@order_destinations).to be_valid
    end
    it '建物名がなくても購入ができる' do
      @order_destinations.building = nil
      expect(@order_destinations).to be_valid
    end
  end

  context '商品購入ができない時' do
    it 'tokenが空だと購入ができない' do
      @order_destinations.token = nil
      @order_destinations.valid?
      expect(@order_destinations.errors.full_messages).to include("Token can't be blank")
    end
    it '郵便番号が空だと購入ができない' do
      @order_destinations.postcode = ''
      @order_destinations.valid?
      expect(@order_destinations.errors.messages).to include(postcode: ["can't be blank", 'is invalid. Include hyphen(-)'])
    end
    it '郵便番号にハイフンがないと登録できない' do
      @order_destinations.postcode = '12345678'
      @order_destinations.valid?
      expect(@order_destinations.errors.full_messages).to include('Postcode is invalid. Include hyphen(-)')
    end
    it '郵便番号が3桁-4桁でないと購入できない' do
      @order_destinations.postcode = '123-458'
      @order_destinations.valid?
      expect(@order_destinations.errors.full_messages).to include('Postcode is invalid. Include hyphen(-)')
    end
    it 'prefecture_idが----だと購入できない' do
      @order_destinations.prefecture_id = 1
      @order_destinations.valid?
      expect(@order_destinations.errors.full_messages).to include("Prefecture can't be blank")
    end
    it 'cityが空だと購入できない' do
      @order_destinations.city = ''
      @order_destinations.valid?
      expect(@order_destinations.errors.full_messages).to include("City can't be blank")
    end
    it 'blockが空だと購入できない' do
      @order_destinations.block = ''
      @order_destinations.valid?
      expect(@order_destinations.errors.full_messages).to include("Block can't be blank")
    end
    it 'phone_numberが空だと購入できない' do
      @order_destinations.phone_number = ''
      @order_destinations.valid?
      expect(@order_destinations.errors.full_messages).to include("Phone number can't be blank")
    end
    it 'phone_numberが英数混合では購入できない' do
      @order_destinations.phone_number = 'o123456789'
      @order_destinations.valid?
      expect(@order_destinations.errors.full_messages).to include('Phone number is invalid')
    end

    it 'phone_numberが9桁以下だと購入できない' do
      @order_destinations.phone_number = '012345678'
      @order_destinations.valid?
      expect(@order_destinations.errors.full_messages).to include('Phone number is invalid')
    end
    it 'phone_numberが12桁以上だと購入できない' do
      @order_destinations.phone_number = '012345678910'
      @order_destinations.valid?
      expect(@order_destinations.errors.full_messages).to include('Phone number is invalid')
    end
    it 'user_idが空だと購入できない' do
      @order_destinations.user_id = ''
      @order_destinations.valid?
      expect(@order_destinations.errors.full_messages).to include("User can't be blank")
    end
    it 'item_idが空だと購入できない' do
      @order_destinations.item_id = ''
      @order_destinations.valid?
      expect(@order_destinations.errors.full_messages).to include("Item can't be blank")
    end
  end
end
