class CreateAssignments < ActiveRecord::Migration[7.1]
  def change
    create_table :assignments do |t|
      t.references :course, null: false, foreign_key: true
      t.string :title, null: false
      t.text :instructions
      t.date :due_on

      t.timestamps
    end

    add_index :assignments, %i[course_id due_on]
  end
end
