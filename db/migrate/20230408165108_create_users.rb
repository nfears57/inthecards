class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :age
      t.float :balance
      t.string :email
      t.string :password_digest
      t.string :photo
      t.string :stats

      t.timestamps
    end
  end
end
