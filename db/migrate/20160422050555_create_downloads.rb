class CreateDownloads < ActiveRecord::Migration
  def change
    create_table :downloads do |t|
      t.integer :cantidad
      t.integer :cantidad_inicial
      t.float :precio
      t.belongs_to :deposit, index:true
      t.belongs_to :store, index:true
      t.belongs_to :product, index:true
      t.string :slug

      t.timestamps
    end
  end
end
