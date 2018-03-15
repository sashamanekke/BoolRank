class AddSessionUserIdToVote < ActiveRecord::Migration[5.1]
  def change
    add_column :votes, :session_user_id, :string
  end
end
