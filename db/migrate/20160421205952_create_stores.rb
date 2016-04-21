class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :nombre
      t.text :direccion
      t.belongs_to :commerce, index:true
      t.string :slug
      t.timestamps
    end
  end
end
