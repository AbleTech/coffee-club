require 'test_helper'

class Admin::RoastsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @roast = roasts(:roast1)
    @header = {"Authorization" => ActionController::HttpAuthentication::Basic.encode_credentials(ENV["ADMIN_USERNAME"], ENV["ADMIN_PASSWORD"])}
  end

  test "should get index" do
    get admin_roasts_url, headers: @header
    assert_response :success
  end

  test "should not get index - not authenticated" do
    get admin_roasts_url
    assert_response 401 #unauthorised
  end

  test "should get new" do
    get new_admin_roast_url, headers: @header
    assert_response :success
  end


  test "should create roast" do
    assert_difference('Roast.count') do
      post admin_roasts_url, params: { roast: { company: @roast.company, description: @roast.description, name: @roast.name } }
    end

    assert_redirected_to admin_roasts_url
  end

  test "should not get new - not authenticated" do
    get new_admin_roast_url
    assert_response 401 #unauthorised
  end


  test "should not create admin_roast - not authenticated" do
    assert_no_difference('Roast.count') do
      post admin_roasts_url, params: { roast: { company: @roast.company, description: @roast.description, roastName: @roast.roastName } }
    end

    assert_response 401 #unauthorised
  end

  test "should get edit" do
    get edit_admin_roast_url(@roast), headers: @header
    assert_response :success
  end

  test "should not get edit - no authentication" do
    get edit_admin_roast_url(@roast)
    assert_response 401 #unauthorised
  end

  test "should update admin_roast" do
    patch admin_roast_url(@roast), params: { roast: { company: @roast.company, description: @roast.description, roastName: @roast.roastName } }, headers: @header
    assert_redirected_to admin_roasts_url
  end

  test "should not update admin_roast - not authenticated" do
    patch admin_roast_url(@roast), params: { roast: { company: @roast.company, description: @roast.description, roastName: @roast.roastName } }
    assert_response 401 #unauthorised
  end

  test "should destroy admin_roast" do
    assert_difference('Roast.count', -1) do
      delete admin_roast_url(@roast), headers: @header
    end

    assert_redirected_to admin_roasts_url
  end

  test "should not destroy admin_roast" do
    assert_no_difference('Roast.count') do
      delete admin_roast_url(@roast)
    end

    assert_response 401
  end


end
