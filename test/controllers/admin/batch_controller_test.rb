require 'test_helper'

class Admin::RoastsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @roast = roasts(:roast1)
    @header = {"Authorization" => ActionController::HttpAuthentication::Basic.encode_credentials(ENV["ADMIN_USERNAME"], ENV["ADMIN_PASSWORD"])}

    @batch = batches(:batch1)

    @batch_params = { batch: { start_date: "2017-11-15 00:00:00", cost: 4.99, amount_purchased: 1, roast_id: @roast.id} }
  end

  test "batch authentication requests" do
    check_for_authentication([
      Request.new(:get, new_admin_roast_url),
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

  test "should create batch" do
    assert_difference('Batch.count') do
      post admin_batches_url, params: @batch_params, headers: @header
    end
    assert_redirected_to admin_roast_url(@batch.roast_id)
    assert_equal @batch.roast_id, @roast.id
  end

  test "should get edit batch" do
    get edit_admin_batch_url(@batch), headers: @header
    assert_response :success
  end

  test "should update batch" do
    patch admin_batch_url(@batch), params: @batch_params, headers: @header
    assert_redirected_to admin_roast_url(@batch.roast_id)
  end

  test "should destroy batch" do
    assert_difference('Batch.count', -1) do
      delete admin_batch_url(@batch), headers: @header
    end
    assert_redirected_to admin_roast_url(@batch.roast_id)
  end



end
