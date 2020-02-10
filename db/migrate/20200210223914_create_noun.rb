class CreateNoun < ActiveRecord::Migration[6.0]
  def change
    create_table :nouns do |t|
      t.string :what, null: false
      t.string :placed_by, null: false

      t.timestamps
    end
  end
end
