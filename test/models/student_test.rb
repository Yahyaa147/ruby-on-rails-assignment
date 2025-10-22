require "test_helper"

class StudentTest < ActiveSupport::TestCase
  test "calculates full name" do
    student = Student.new(first_name: "Ali", last_name: "Yildiz", email: "ali@example.com")
    assert_equal "Ali Yildiz", student.full_name
  end

  test "requires unique email" do
    Student.create!(first_name: "Ali", last_name: "Yildiz", email: "ali@example.com")
    duplicate = Student.new(first_name: "Elif", last_name: "Sahin", email: "ali@example.com")

    assert_not duplicate.valid?
  end
end
