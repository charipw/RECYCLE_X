class AddExamplesToPackagings < ActiveRecord::Migration[7.0]
  def change
    add_column :packagings, :examples, :string
  end
end
