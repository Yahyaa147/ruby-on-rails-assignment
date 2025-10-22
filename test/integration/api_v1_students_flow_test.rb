require "test_helper"

class ApiV1StudentsFlowTest < ActionDispatch::IntegrationTest
  test "creates and lists students" do
    assert_difference("Student.count", 1) do
      post "/api/v1/students", params: { student: { first_name: "Ali", last_name: "Yildiz", email: "ali@example.com" } }
    end

    assert_response :created

    get "/api/v1/students"
    assert_response :success

    payload = JSON.parse(response.body)
    assert_equal 1, payload.size
  end
end
