class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.string :name, null: false
      t.index :name
      t.string :email, null: false
      t.index :email, unique: true

      t.timestamps
    end
  end
end
