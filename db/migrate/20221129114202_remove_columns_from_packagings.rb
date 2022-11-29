class RemoveColumnsFromPackagings < ActiveRecord::Migration[7.0]
  def change
    remove_column :packagings, :eco_score, :string
    remove_column :packagings, :carbon_footprint, :integer
  end
end
