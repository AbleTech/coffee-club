require 'test_helper'

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
    assert_select 'h2', "People's Don Wilfredo Espresso"
    assert_select 'p', "Our flagship blend is complex, a full bodied flavour juggernaught with chocolate sweetness and creamy caramel overtones. The 'Don' is roasted for espresso but also works well as a full-bodied plunger."
    assert_select 'p', "No batches have been created"

    # add a new batch
    get new_admin_batch_path(:roast => @roast), headers: @header
    assert_response :success
    assert_difference('Batch.count') do
      post admin_batches_url, params: { batch: { starts_at: "2017-11-12 00:00:00", cost: 4.99, amount_purchased: 1, roast_id: @roast.id} }, headers: @header
    end
    assert_redirected_to admin_root_url
    assert_equal @batch.roast, @roast

    # check the roasts page displays what we expect
    get admin_roast_url(@roast), headers: @header
    assert_response :success
    assert_select 'h2', "People's Don Wilfredo Espresso"
    assert_select 'p', "Our flagship blend is complex, a full bodied flavour juggernaught with chocolate sweetness and creamy caramel overtones. The 'Don' is roasted for espresso but also works well as a full-bodied plunger."
    assert_select 'td', "Sun 12 Nov 2017"
    assert_select 'td:nth-child(2)', "$4.99"
    assert_select 'td:nth-child(3)', "1"
  end

  test "homepage displays correctly when there are batches" do
    get '/'
    assert_response :success

    # Check current roast is correct
    assert_select "h1", "The Abletech Coffee Club"
    assert_select "h2", "Current Roast"
    assert_select "h4", "People's Colombia Popayan"
    assert_select "p", "Start Date: Mon 20 Nov 2017"

    # Check vote count is correct
    assert_select "h1", "2"

    # Check top roasts displaying correctly
    expected_result = ["#1", "People's Colombia Popayan", "2", "2", "0", "4"]
    (1..6).each do |index|
      assert_select "tr:nth-child(1)>td:nth-child(#{index})", expected_result[index-1]
    end

    expected_result = ["#2", "People's Don Wilfredo Espresso", "0", "0", "0", "0"]
    (1..6).each do |index|
      assert_select "tr:nth-child(2)>td:nth-child(#{index})", expected_result[index-1]
    end
  end

  test "admin dashboard displays correctly when there are batches" do
    get '/admin', headers: @header
    assert_response :success
    assert_select "table", 2

    # Check current roast is correct
    assert_select "h1", "Admin Dashboard"
    assert_select "h2", "Current Roast"
    assert_select "h4", "People's Colombia Popayan"
    assert_select "p", "Start Date: Mon 20 Nov 2017"

    # Check vote count is correct
    assert_select "h1", "2"

    # Check top roasts displaying correctly
    result = [
      ["#1", "People's Colombia Popayan", "2", "2", "0", "4"],
      ["#2", "People's Don Wilfredo Espresso", "0", "0", "0", "0"]
    ]
    (0..1).each do |row|
      (0..5).each do |index|
        assert_select "tr:nth-child(#{row+1})>td:nth-child(#{index+1})", result[row][index]
      end
    end

    # Check last batches displaying correctly
    assert_select "h2", "Last 10 Batches"
    result = [
      ["People's Colombia Popayan", "Mon 20 Nov 2017", "$0.10"],
      ["People's Colombia Popayan", "Tue 07 Nov 2017", "$0.10"],
      ["People's Don Wilfredo Espresso", "Sun 05 Nov 2017", "$0.10"]
    ]
    (0..2).each do |row|
      (0..2).each do |index|
        assert_select "table.batches-table>tr:nth-child(#{row+2})>td:nth-child(#{index+1})", result[row][index]
      end
    end
  end

  test "homepage displays correctly when there are no batches" do
    Batch.delete_all
    get '/'
    assert_response :success

    # Check dashboard is displaying correctly
    assert_select "h1", "The Abletech Coffee Club"
    assert_select "h2", "There are no batches that are currently active."
    assert_select "h2", "Ask Carl to add an active roast."
  end

  test "admin dashboard displays correctly when there are no batches" do
    Batch.delete_all
    get '/admin', headers: @header
    assert_response :success

    assert_select "h1", "Admin Dashboard"
    assert_select "p", "There are no batches currently active, click the button below to start one."
    assert_select "table", false, "There should not be a batches table because they don't exist"
  end
end
