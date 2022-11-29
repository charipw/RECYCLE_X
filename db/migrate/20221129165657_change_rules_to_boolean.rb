class ChangeRulesToBoolean < ActiveRecord::Migration[7.0]
  def change
    change_column :rules, :is_recycled, 'boolean USING CAST(is_recycled AS boolean)'
  end
end
