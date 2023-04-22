require 'rails_helper'

RSpec.describe OrderDestinations, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item)
    @item.image = fixture_file_upload('public/images/test_image.png')
    @item.save
    @order_destinations = FactoryBot.build(:order_destinations, user_id: @user.id, item_id: @item.id)
    sleep 0.1
  end

  it '全ての項目が入力されていれば購入ができる' do
    expect(@order_destinations).to be_valid
  end
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
    expect(@order_destinations.errors.full_messages).to include("Phone number can't be blank", 'Phone number is invalid')
  end
  it 'phone_numberが11桁でなければ購入できない' do
    @order_destinations.phone_number = '012345678910'
    @order_destinations.valid?
    expect(@order_destinations.errors.full_messages).to include('Phone number is invalid')
  end
end
