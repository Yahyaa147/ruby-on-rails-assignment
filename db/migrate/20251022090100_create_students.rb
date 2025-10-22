class CreateStudents < ActiveRecord::Migration[7.1]
  def change
    create_table :students do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :status, null: false, default: "active"

      t.timestamps
    end

    add_index :students, :email, unique: true
  end
end
