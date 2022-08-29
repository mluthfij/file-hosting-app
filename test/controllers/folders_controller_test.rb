require "test_helper"

class FoldersControllerTest < ActionDispatch::IntegrationTest
  test "should get _folder" do
    get folders__folder_url
    assert_response :success
  end

  test "should get _form" do
    get folders__form_url
    assert_response :success
  end

  test "should get show" do
    get folders_show_url
    assert_response :success
  end
end
