require "test_helper"

class ApiV1GreetingsTest < ActionDispatch::IntegrationTest
  test "returns hello payload" do
    get "/api/v1/hello"
    assert_response :success

    payload = JSON.parse(response.body)
    assert_equal "Hello from Odev API", payload.fetch("message")
  end
end
