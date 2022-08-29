require "test_helper"

class ReposControllerTest < ActionDispatch::IntegrationTest
  setup do
    @repo = repos(:one)
  end

  test "should get index" do
    get repos_url
    assert_response :success
  end

  test "should get new" do
    get new_repo_url
    assert_response :success
  end

  test "should create repo" do
    assert_difference('Repo.count') do
      post repos_url, params: { repo: { name: @repo.name } }
    end

    assert_redirected_to repo_url(Repo.last)
  end

  test "should show repo" do
    get repo_url(@repo)
    assert_response :success
  end

  test "should get edit" do
    get edit_repo_url(@repo)
    assert_response :success
  end

  test "should update repo" do
    patch repo_url(@repo), params: { repo: { name: @repo.name } }
    assert_redirected_to repo_url(@repo)
  end

  test "should destroy repo" do
    assert_difference('Repo.count', -1) do
      delete repo_url(@repo)
    end

    assert_redirected_to repos_url
  end
end
