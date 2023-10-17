class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :address, :building, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :token
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :prefecture_id
    validates :city
    validates :address
    validates :phone_number, format: { with: /\A\d{10,11}\z/ }
    validates :user_id
    validates :item_id
  end
  validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }

  def save
    purchase = Purchase.create(user_id:, item_id:)
    Address.create(postal_code:, prefecture_id:, city:, address:, building:,
                    phone_number:, purchase_id: purchase.id)
  end
end
