require 'test_helper'
 
class InquirySearchTest < ActionDispatch::IntegrationTest
  test "paginate inquiry" do
    11.times { create(:inquiry) }
    post_via_redirect "/auth/github"

    get "/inquiries/search", :q => "example"
    assert_response :success
    assert_match /next/, @response.body
  end

  test "show inquiry" do
    @inquiry = create(:inquiry)
    post_via_redirect "/auth/github"

    get "/inquiries", :id => @inquiry.id
    assert_response :success
  end
end