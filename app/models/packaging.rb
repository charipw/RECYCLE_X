class Packaging < ApplicationRecord
  has_many :rules
  self.inheritance_column = :_type_disabled

  def packaging_label
    "#{category} - #{type}<hint class=\"custom-tooltip\" data-content=\"#{examples}\"><i class=\"fa-solid fa-circle-info\"></i></hint>".html_safe
  end

  # include PgSearch::Model
  # pg_search_scope :search_by_category_and_type,
  #   against: [ :category, :type ],
  #   using: {
  #     tsearch: { prefix: true } # <-- now `superman batm` will return something!
  # }
end
