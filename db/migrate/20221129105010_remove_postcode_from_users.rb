class RemovePostcodeFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :postcode, :string
  end
end
