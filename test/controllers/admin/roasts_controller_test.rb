require 'test_helper'

class Admin::RoastsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @roast = roasts(:roast1)
    @header = {"Authorization" => ActionController::HttpAuthentication::Basic.encode_credentials(ENV["ADMIN_USERNAME"], ENV["ADMIN_PASSWORD"])}

    @roast_params = { roast: { company: @roast.company, description: @roast.description, name: @roast.name } }

    @get_urls = [admin_roasts_url, new_admin_roast_url, edit_admin_roast_url(@roast)]
    @post_urls = [admin_roasts_url]
    @delete_urls = [admin_roast_url(@roast)]
    @patch_urls = [admin_roast_url(@roast)]
  end

  test "invalid requests" do
    check_invalid_urls :get, @get_urls, false
    check_invalid_urls :post, @post_urls, true
    check_invalid_urls :delete, @delete_urls, true
    check_invalid_urls :patch, @patch_urls, true
  end

  test "should get index" do
    get admin_roasts_url, headers: @header
    assert_response :success
  end

  test "should get new" do
    get new_admin_roast_url, headers: @header
    assert_response :success
  end

  test "should create roast" do
    assert_difference('Roast.count') do
      post admin_roasts_url, params: @roast_params, headers: @header
    end
    assert_redirected_to admin_roasts_url
  end

  test "should get edit" do
    get edit_admin_roast_url(@roast), headers: @header
    assert_response :success
  end

  test "should update roast" do
    patch admin_roast_url(@roast), params: @roast_params, headers: @header
    assert_redirected_to admin_roasts_url
  end

  test "should destroy roast" do
    assert_difference('Roast.count', -1) do
      delete admin_roast_url(@roast), headers: @header
    end
    assert_redirected_to admin_roasts_url
  end

  private

  # Assert that the response is a 401 (unauthorised)
  def check_invalid_authentication
    assert_response 401
  end

  # Check a set of URLS based on the type of request and if it requires params
  def check_invalid_urls(type, urls, needs_params)
    urls.each do |url|
      needs_params ? send(type, url, params: {}) : send(type, url)
      check_invalid_authentication
    end
  end
end
