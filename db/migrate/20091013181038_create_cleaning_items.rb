class CreateCleaningItems < ActiveRecord::Migration
  def self.up
    create_table :cleaning_items do |t|
      t.string :title
      t.text :description
      t.integer :counter
      t.integer :intervall
      t.boolean :active

      t.timestamps
    end
  end

  def self.down
    drop_table :cleaning_items
  end
end
