class CreateWagers < ActiveRecord::Migration[7.0]
  def change
    create_table :wagers do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :game, null: false, foreign_key: true
      t.float :bet

      t.timestamps
    end
  end
end
