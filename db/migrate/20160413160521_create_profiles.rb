class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :primer_nombre
      t.string :segundo_nombre
      t.string :primer_apellido
      t.string :segundo_apellido
      t.boolean :sexo
      t.string :email
      t.string :celular
      t.string :slug
      
      t.timestamps
    end
  end
end
