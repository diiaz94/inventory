class CreateCommerces < ActiveRecord::Migration
  def change
    create_table :commerces do |t|
      t.string :nombre
      t.text :descripcion
      t.belongs_to :profile, index:true
      t.string :slug
      t.timestamps
    end
  end
end
