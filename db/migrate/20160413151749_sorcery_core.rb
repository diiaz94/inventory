class SorceryCore < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :cedula,            :null => false
      t.string :crypted_password
      t.string :salt
      t.string :slug 
      t.timestamps
    end

    add_index :users, :cedula, unique: true
  end
end	