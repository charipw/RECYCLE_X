class Item < ApplicationRecord
  has_one_attached :photo
  has_many :item_users, dependent: :destroy
  has_many :item_packagings, dependent: :destroy, inverse_of: :item
  has_many :packagings, through: :item_packagings

  accepts_nested_attributes_for :item_packagings
end
