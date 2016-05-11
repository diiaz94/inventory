class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.integer :cantidad
      t.float :precio
      t.belongs_to :bill, index: true
      t.timestamps
    end
  end
end
