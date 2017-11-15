require 'test_helper'

class Admin::RoastsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @roast = roasts(:roast1)
  end

  test "should get index" do
    get admin_roasts_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_roast_url
    assert_response :success
  end

  test "should create roast" do
    assert_difference('Roast.count') do
      post admin_roasts_url, params: { roast: { company: @roast.company, description: @roast.description, name: @roast.name } }
    end

    assert_redirected_to admin_roasts_url
  end

  test "should get edit" do
    get edit_admin_roast_url(@roast)
    assert_response :success
  end

  test "should update roast" do
    patch admin_roast_url(@roast), params: { roast: { company: @roast.company, description: @roast.description, name: @roast.name } }
    assert_redirected_to admin_roasts_url
  end

  test "should destroy roast" do
    assert_difference('Roast.count', -1) do
      delete admin_roast_url(@roast)
    end

    assert_redirected_to admin_roasts_url
  end
end
