class AddVerbToFacts < ActiveRecord::Migration
  def change
    add_column :facts, :verb, :string
  end
end
