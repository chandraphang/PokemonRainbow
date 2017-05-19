class CreateTrainers < ActiveRecord::Migration[5.0]
  def change
    create_table :trainers do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password, null: false
      t.timestamps
    end
    add_index :trainers, :email, unique: true
  end
end
