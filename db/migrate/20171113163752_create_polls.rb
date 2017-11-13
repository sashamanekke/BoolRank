class CreatePolls < ActiveRecord::Migration[5.1]
  def change
    create_table :polls do |t|
      t.string :title
      t.text :description
      t.string :photo
      t.boolean :status
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
