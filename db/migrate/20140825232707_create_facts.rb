class CreateFacts < ActiveRecord::Migration
  def change
    create_table :facts do |t|
      t.string :trigger, null: false
      t.string :fact, null: false
      t.timestamps
    end
  end
end
