require "test_helper"

class ItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get _form" do
    get items__form_url
    assert_response :success
  end

  test "should get _Item" do
    get items__Item_url
    assert_response :success
  end

  test "should get show" do
    get items_show_url
    assert_response :success
  end
end
