class CreatePropositions < ActiveRecord::Migration[5.1]
  def change
    create_table :propositions do |t|
      t.string :name
      t.integer :score
      t.string :photo
      t.string :hashtag
      t.text :description
      t.references :poll, foreign_key: true

      t.timestamps
    end
  end
end
