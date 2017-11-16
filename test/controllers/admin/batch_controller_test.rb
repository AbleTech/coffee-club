require 'test_helper'

class Admin::RoastsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @roast = roasts(:roast1)
    @header = {"Authorization" => ActionController::HttpAuthentication::Basic.encode_credentials(ENV["ADMIN_USERNAME"], ENV["ADMIN_PASSWORD"])}

    @batch = batches(:batch1)

    @batch_params = { batch: { start_date: "2017-11-15 00:00:00", cost: 4.99, amount_purchased: 1, roast_id: @roast.id} }
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



end
