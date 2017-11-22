class AddOpenAndPublicToPolls < ActiveRecord::Migration[5.1]
  def change
    add_column :polls, :closed, :boolean
    add_column :polls, :public_poll, :boolean
  end
end
