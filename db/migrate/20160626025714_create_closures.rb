class CreateClosures < ActiveRecord::Migration
  def change
    create_table :closures do |t|
      t.belongs_to :seller, index:true

      t.timestamps
    end
  end
end
