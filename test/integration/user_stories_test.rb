class UserStoriesTest < ActionDispatch::IntegrationTest
  setup do
    @roast = roasts(:roast1)
    @batch = batches(:batch1)
    @header = {"Authorization" => ActionController::HttpAuthentication::Basic.encode_credentials(ENV["ADMIN_USERNAME"], ENV["ADMIN_PASSWORD"])}
  end

  test "create some roasts and batches" do
    Batch.delete_all

    # Visit list of roasts
    get admin_roasts_url, headers: @header
    assert_response :success

    # add a new roast
    assert_difference('Roast.count') do
      post admin_roasts_url, params: { roast: { company: @roast.company, description: @roast.description, name: @roast.name } }, headers: @header
    end
    assert_redirected_to admin_roasts_url

    # check the roasts page displays what we expect
    get admin_roasts_url, headers: @header
    assert_response :success
    assert_select 'h1', "List of All Roasts"
    assert_select 'td', "People's"
    assert_select 'td', "Don Wilfredo Espresso"
    assert_select 'td', "Our flagship blend is complex, a full bodied flavour juggernaught with chocolate sweetness and creamy caramel overtones. The 'Don' is roasted for espresso but also works well as a full-bodied plunger."

    # check the people's don wilfredo espresso page
    get admin_roast_url(@roast), headers: @header
    assert_response :success
    assert_select 'h3', "People's Don Wilfredo Espresso"
    assert_select 'h4', "About"
    assert_select 'p', "Our flagship blend is complex, a full bodied flavour juggernaught with chocolate sweetness and creamy caramel overtones. The 'Don' is roasted for espresso but also works well as a full-bodied plunger."
    assert_select 'p', "No batches have been created"

    # add a new batch
    get new_admin_batch_path(:roast => @roast), headers: @header
    assert_response :success
    assert_difference('Batch.count') do
      post admin_batches_url, params: { batch: { start_date: "2017-11-15 00:00:00", cost: 4.99, amount_purchased: 1, roast_id: @roast.id} }, headers: @header
    end
    assert_redirected_to admin_roast_url(@batch.roast)
    assert_equal @batch.roast, @roast

    # check the roasts page displays what we expect
    get admin_roast_url(@roast), headers: @header
    assert_response :success
    assert_select 'h3', "People's Don Wilfredo Espresso"
    assert_select 'h4', "About"
    assert_select 'p', "Our flagship blend is complex, a full bodied flavour juggernaught with chocolate sweetness and creamy caramel overtones. The 'Don' is roasted for espresso but also works well as a full-bodied plunger."
    assert_select 'td', "Wed 15 Nov 2017"
    assert_select 'td:nth-child(2)', "$4.99"
    assert_select 'td:nth-child(3)', "1"
  end
end
