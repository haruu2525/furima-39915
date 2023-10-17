class PurchasesController < ApplicationController
  before_action :set_public_key, only: [:index, :create]
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :redirect_to_root

  def index
    @purchase_address = PurchaseAddress.new

  end

  def create
    @purchase_address = PurchaseAddress.new(purchase_params)
    
    if @purchase_address.valid?
      pay_item
      @purchase_address.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :index, status: :unprocessable_entity
    end
  end

  private

  def purchase_params
    params.require(:purchase_address).permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number, :purchase).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      card: purchase_params[:token], # カードトークン
      currency: 'jpy' # 通貨の種類（日本円）
    )
  end

  def set_public_key
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
  end

  def redirect_to_root
    
    return unless current_user.id == @item.user.id || !@item.purchase.nil?
    redirect_to root_path
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
  
end
