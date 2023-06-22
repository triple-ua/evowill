require "test_helper"

class ConsumerControllerTest < ActionDispatch::IntegrationTest
  test "should get json" do
    get consumer_json_url
    assert_response :success
  end
end
