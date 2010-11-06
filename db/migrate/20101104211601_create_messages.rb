class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.string :message, :null => false
      t.references :codroo, :null => false
      t.references :user, :null => false
      t.references :message, :null => false, :default => "0"
      t.boolean :active, :default => true
      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
