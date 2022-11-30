class ItemPackaging < ApplicationRecord
  belongs_to :item
  belongs_to :packaging
end
