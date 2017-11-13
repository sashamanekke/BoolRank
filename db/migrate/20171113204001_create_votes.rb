class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.references :poll, foreign_key: true
      t.references :user, foreign_key: true
      t.references :accepted_proposition
      t.references :rejected_proposition

      t.timestamps
    end
  end
end
