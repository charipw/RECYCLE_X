class Item < ApplicationRecord
  has_one_attached :photo
  has_many :packagings, :users
end
