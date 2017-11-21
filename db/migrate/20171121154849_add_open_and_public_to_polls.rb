class AddOpenAndPublicToPolls < ActiveRecord::Migration[5.1]
  def change
    add_column :polls, :open, :boolean
    add_column :polls, :public, :boolean
  end
end
