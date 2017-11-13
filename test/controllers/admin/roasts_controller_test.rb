require 'test_helper'

class Admin::RoastsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_roast = admin_roasts(:people1)
  end

  test "should get index" do
    get admin_roasts_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_roast_url
    assert_response :success
  end

  test "should create admin_roast" do
    assert_difference('Admin::Roast.count') do
      post admin_roasts_url, params: { admin_roast: { company: @admin_roast.company, description: @admin_roast.description, roastName: @admin_roast.roastName } }
    end

    assert_redirected_to admin_roast_url(Admin::Roast.last)
  end

  test "should show admin_roast" do
    get admin_roast_url(@admin_roast)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_roast_url(@admin_roast)
    assert_response :success
  end

  test "should update admin_roast" do
    patch admin_roast_url(@admin_roast), params: { admin_roast: { company: @admin_roast.company, description: @admin_roast.description, roastName: @admin_roast.roastName } }
    assert_redirected_to admin_roast_url(@admin_roast)
  end

  test "should destroy admin_roast" do
    assert_difference('Admin::Roast.count', -1) do
      delete admin_roast_url(@admin_roast)
    end

    assert_redirected_to admin_roasts_url
  end
end
