class AddBoroughToRules < ActiveRecord::Migration[7.0]
  def change
    add_reference :rules, :borough, null: false, foreign_key: true
  end
end
