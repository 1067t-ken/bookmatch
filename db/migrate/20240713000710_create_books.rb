class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :isbn

      t.timestamps
      t.index :isbn
    end
  end
end
