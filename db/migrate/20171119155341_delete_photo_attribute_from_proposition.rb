class DeletePhotoAttributeFromProposition < ActiveRecord::Migration[5.1]
  def change
    remove_column :propositions, :photo
  end
end
