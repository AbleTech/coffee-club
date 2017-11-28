require 'test_helper'

class Admin::BatchesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @header = {"Authorization" => ActionController::HttpAuthentication::Basic.encode_credentials(ENV["ADMIN_USERNAME"], ENV["ADMIN_PASSWORD"])}

    @roast = roasts(:roast1)
    @batch = batches(:batch1)
    @batch_params = { batch: { starts_at: "2017-11-11 00:00:00", cost: 4.99, amount_purchased: 1, roast_id: @roast.id} }
  end

  test "batch authentication requests" do
    check_for_authentication([
      Request.new(:get, new_admin_batch_url),
      Request.new(:get, edit_admin_batch_url(@batch)),
      Request.new(:post, admin_batches_url),
      Request.new(:delete, admin_batch_url(@batch)),
      Request.new(:patch, admin_batch_url(@batch))
    ])
  end

  test "should get new batch" do
    get new_admin_batch_path(:roast => @roast), headers: @header
    assert_response :success
  end

  test "should get new batch - with no roast" do
    get new_admin_batch_path, headers: @header
    assert_response :success
  end

  test "should get new batch - with invalid roast" do
    get new_admin_batch_path(:roast => 1234576), headers: @header
    assert_response :success
  end

  test "should create batch" do
    assert_difference('Batch.count') do
      post admin_batches_url, params: @batch_params, headers: @header
    end
    assert_redirected_to admin_roast_url(@roast)
    assert_equal @batch.roast, @roast
  end

  test "should get edit batch" do
    get edit_admin_batch_url(@batch), headers: @header
    assert_response :success
  end

  test "should update batch" do
    patch admin_batch_url(@batch), params: @batch_params, headers: @header
    assert_redirected_to admin_root_url
  end

  test "should destroy batch" do
    assert_difference('Batch.count', -1) do
      delete admin_batch_url(@batch), headers: @header
    end
    assert_redirected_to admin_root_url
  end
end
