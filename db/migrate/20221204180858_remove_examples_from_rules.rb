class RemoveExamplesFromRules < ActiveRecord::Migration[7.0]
  def change
    remove_column :rules, :examples
  end
end
