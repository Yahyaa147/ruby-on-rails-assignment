class CreateCourses < ActiveRecord::Migration[7.1]
  def change
    create_table :courses do |t|
      t.string :title, null: false
      t.string :code, null: false
      t.text :description
      t.references :teacher, null: false, foreign_key: true

      t.timestamps
    end

    add_index :courses, :code, unique: true
  end
end
