class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :nombre
      t.string :abv
      t.text :descripcion
	  t.string :slug
      t.timestamps
    end
  end
end
