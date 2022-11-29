class Borough < ApplicationRecord
  has_many :users
  has_many :rules, dependent: :destroy
  validates :name, presence: true
end
