require 'test_helper'


class Admin::RoastsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @roast = roasts(:roast1)
    @header = {"Authorization" => ActionController::HttpAuthentication::Basic.encode_credentials(ENV["ADMIN_USERNAME"], ENV["ADMIN_PASSWORD"])}

    @roast_params = { roast: { company: @roast.company, description: @roast.description, name: @roast.name } }
  end

  test "authentication requests" do
    check_for_authentication([
      Request.new(:get, admin_roasts_url),
      Request.new(:get, new_admin_roast_url),
      Request.new(:get, edit_admin_roast_url(@roast)),
      Request.new(:post, admin_roasts_url),
      Request.new(:delete, admin_roast_url(@roast)),
      Request.new(:patch, admin_roast_url(@roast))
    ])
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
end
