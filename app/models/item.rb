class Item < ApplicationRecord
  has_one_attached :photo
  has_many :item_users, dependent: :destroy
  has_many :item_packagings, dependent: :destroy
  has_many :packagings, through: :item_packagings
end
