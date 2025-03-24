class CreateDrivers < ActiveRecord::Migration[7.1]
  def change
    create_table :drivers do |t|
      t.string :first_name
      t.string :last_name
      t.string :api_id
      t.integer :number
      t.string :code

      t.timestamps
    end
  end
end
