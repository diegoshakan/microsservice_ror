class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :unity
      t.string :color

      t.timestamps
    end
  end
end
