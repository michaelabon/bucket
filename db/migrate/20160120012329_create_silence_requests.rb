class CreateSilenceRequests < ActiveRecord::Migration
  def change
    create_table :silence_requests do |t|
      t.string :requester, null: false
      t.datetime :silence_until, null: false
    end
  end
end
