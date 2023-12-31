require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @purchase_address = FactoryBot.build(:purchase_address, user_id: @user.id, item_id: @item.id)
  end

  context '内容に問題ない場合' do
    it "全ての値があれば保存ができること" do
      expect(@purchase_address).to be_valid
    end
    it "建物名が空でも保存ができること" do
      @purchase_address.building = ""
      expect(@purchase_address).to be_valid
    end
  end

  context '内容に問題がある場合' do
    it "郵便番号が空では登録できないこと" do
      @purchase_address.postal_code = nil
      @purchase_address.valid?
      expect(@purchase_address.errors.full_messages).to include("Postal code can't be blank")
    end

    it "郵便番号が「3桁ハイフン4桁」の半角文字列のみ意外では登録できないこと" do
      @purchase_address.postal_code = nil
      @purchase_address.valid?
      expect(@purchase_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
    end

    it "都道府県が空では登録できないこと" do
      @purchase_address.prefecture_id = 0
      @purchase_address.valid?
      expect(@purchase_address.errors.full_messages).to include("Prefecture can't be blank")
    end

    it "市区町村が空では登録できないこと" do
      @purchase_address.city = nil
      @purchase_address.valid?
      expect(@purchase_address.errors.full_messages).to include("City can't be blank")
    end

    it "番地が空では登録できないこと" do
      @purchase_address.address = nil
      @purchase_address.valid?
      expect(@purchase_address.errors.full_messages).to include("Address can't be blank")
    end

    it "電話番号が空では登録できないこと" do
      @purchase_address.phone_number = nil
      @purchase_address.valid?
      expect(@purchase_address.errors.full_messages).to include("Phone number can't be blank")
    end

    it "電話番号が10桁以上11桁以内の半角数値のみ以外では登録できないこと" do
      @purchase_address.phone_number = nil
      @purchase_address.valid?
      expect(@purchase_address.errors.full_messages).to include("Phone number is invalid")
    end

    it "電話番号が9桁以下では登録できないこと" do
      @purchase_address.phone_number = 777777
      @purchase_address.valid?
      expect(@purchase_address.errors.full_messages).to include("Phone number is invalid")
    end

    it "電話番号が12桁以上では登録できないこと" do
      @purchase_address.phone_number = 77777777777777
      @purchase_address.valid?
      expect(@purchase_address.errors.full_messages).to include("Phone number is invalid")
    end

    it "user_idが空では登録できないこと" do
      @purchase_address.user_id = nil
      @purchase_address.valid?
      expect(@purchase_address.errors.full_messages).to include("User can't be blank")
    end

    it "item_idが空では登録できないこと" do
      @purchase_address.item_id = nil
      @purchase_address.valid?
      expect(@purchase_address.errors.full_messages).to include("Item can't be blank")
    end

    it "tokenが空では登録できないこと" do
      @purchase_address.token = nil
      @purchase_address.valid?
      expect(@purchase_address.errors.full_messages).to include("Token can't be blank")
    end
  end
end