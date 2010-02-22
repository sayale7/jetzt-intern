class CreateFinishedCleans < ActiveRecord::Migration
  def self.up
    create_table :finished_cleans do |t|
      t.integer :cleaning_item_id
      t.string :title
      t.integer :user_id
      t.timestamp :when_finished

      t.timestamps
    end
  end

  def self.down
    drop_table :finished_cleans
  end
end
