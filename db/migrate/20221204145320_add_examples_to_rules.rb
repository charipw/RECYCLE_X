class AddExamplesToRules < ActiveRecord::Migration[7.0]
  def change
    add_column :rules, :examples, :string
  end
end
