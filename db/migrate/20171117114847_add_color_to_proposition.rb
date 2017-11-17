class AddColorToProposition < ActiveRecord::Migration[5.1]
  def change
    add_column :propositions, :color, :string
  end
end
