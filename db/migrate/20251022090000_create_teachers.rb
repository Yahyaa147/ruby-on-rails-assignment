class CreateTeachers < ActiveRecord::Migration[7.1]
  def change
    create_table :teachers do |t|
      t.string :full_name, null: false
      t.string :email, null: false
      t.string :department

      t.timestamps
    end

    add_index :teachers, :email, unique: true
  end
end
