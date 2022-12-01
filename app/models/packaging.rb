class Packaging < ApplicationRecord
  self.inheritance_column = :_type_disabled

  # include PgSearch::Model
  # pg_search_scope :search_by_category_and_type,
  #   against: [ :category, :type ],
  #   using: {
  #     tsearch: { prefix: true } # <-- now `superman batm` will return something!
  # }
end
