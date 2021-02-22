class CreateTaggings < ActiveRecord::Migration[6.1]
  def change
    create_table :taggings do |t|
      t.belongs_to :contact, foreign_key: true
      t.belongs_to :tag, foreign_key: true
      t.index [:contact_id, :tag_id], unique: true

      t.timestamps
    end
  end
end
