class CreateLoads < ActiveRecord::Migration
  def change
    create_table :loads do |t|
      t.integer :cantidad
      t.float :precio
      t.belongs_to :deposit, index:true
      t.belongs_to :product, index:true
      t.string :slug
      t.timestamps
    end
  end
end
