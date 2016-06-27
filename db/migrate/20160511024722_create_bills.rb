class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.float :total
      t.float :pago
      t.belongs_to :seller, index: true
      t.belongs_to :closure
      t.timestamps
    end
  end
end
