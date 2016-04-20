class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :nombre
      t.text :descripcion
      t.belongs_to :category
      t.belongs_to :unit, index:true
      t.belongs_to :brand, index:true
      t.string :slug
      t.timestamps
    end
  end
end
