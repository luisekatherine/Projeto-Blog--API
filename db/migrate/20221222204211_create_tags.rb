class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.string :name, null: false, limit: 20

      t.timestamps #é o que garante o created at e updated at
    end
    add_index :tags, :name, unique: true
  end
end
