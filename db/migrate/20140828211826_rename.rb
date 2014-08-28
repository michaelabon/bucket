class Rename < ActiveRecord::Migration
  def change
    rename_column :facts, :fact, :result
  end
end
