require "test_helper"

class TeacherTest < ActiveSupport::TestCase
  test "is invalid without essential attributes" do
    teacher = Teacher.new
    assert_not teacher.valid?
    assert_includes teacher.errors[:full_name], "can't be blank"
    assert_includes teacher.errors[:email], "can't be blank"
  end

  test "enforces unique email addresses" do
    Teacher.create!(full_name: "Existing Teacher", email: "teacher@example.com")
    duplicate = Teacher.new(full_name: "Other Teacher", email: "teacher@example.com")

    assert_not duplicate.valid?
  end
end
