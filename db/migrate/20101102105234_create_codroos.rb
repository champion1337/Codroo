class CreateCodroos < ActiveRecord::Migration
  def self.up
    create_table :codroos do |t|
      t.references :user
      t.string :name, :null => false
      t.string :description, :null => false
      t.string :formula, :null => false
      t.boolean :active, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :codroos
  end
end
