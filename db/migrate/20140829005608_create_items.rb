class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :what, null: false
      t.string :placed_by, null: false
      t.timestamps
    end
  end
end
