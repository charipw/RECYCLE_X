class AddPackagingToRules < ActiveRecord::Migration[7.0]
  def change
    add_reference :rules, :packaging, null: false, foreign_key: true
  end
end
