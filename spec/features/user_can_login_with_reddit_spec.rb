require 'rails_helper'

RSpec.feature "User can login with Reddit" do
  scenario "they visit the root path" do
    RandomString.create!(word: 'hello')
    params = {
      "state": "hello",
      "code": "example",
      "controller": "sessions",
      "action": "process_auth_response"
    }
    user_hash = {
      "is_employee"=>false,
      "name"=>"test",
      "created"=>1322730741.0,
      "hide_from_robots"=>true,
      "is_suspended"=>false,
      "created_utc"=>1322701941.0,
      "link_karma"=>392,
      "in_beta"=>false,
      "comment_karma"=>1425,
      "features"=>{
        "adzerk_reporting_2"=>true,
        "live_happening_now"=>true,
        "adserver_reporting"=>true,
        "legacy_search_pref"=>true,
        "mobile_web_targeting"=>true,
        "orangereds_as_emails"=>true,
        "adzerk_do_not_track"=>true,
        "sticky_comments"=>true,
        "upgrade_cookies"=>true,
        "ads_auto_refund"=>true,
        "ads_auction"=>true,
        "imgur_gif_conversion"=>true,
        "expando_events"=>true,
        "eu_cookie_policy"=>true,
        "force_https"=>true,
        "mobile_native_banner"=>true,
        "do_not_track"=>true,
        "outbound_clicktracking"=>true,
        "image_uploads"=>true,
        "new_loggedin_cache_policy"=>true,
        "https_redirect"=>true,
        "screenview_events"=>true,
        "pause_ads"=>true,
        "give_hsts_grants"=>true,
        "new_report_dialog"=>true,
        "moat_tracking"=>true,
        "subreddit_rules"=>true,
        "timeouts"=>true,
        "mobile_settings"=>true,
        "youtube_scraper"=>true,
        "activity_service_write"=>true,
        "ads_auto_extend"=>true,
        "post_embed"=>true,
        "scroll_events"=>true,
        "adblock_test"=>true,
        "activity_service_read"=>true
      },
      "over_18"=>true,
      "is_gold"=>false,
      "is_mod"=>false,
      "id"=>"test",
      "gold_expiration"=>nil,
      "inbox_count"=>0,
      "has_verified_email"=>false,
      "gold_creddits"=>0,
      "suspension_expiration_utc"=>nil
    }

    allow_any_instance_of(SessionsController).
      to receive(:random_string).
      and_return("hello")

    allow_any_instance_of(SessionsController).
      to receive(:reddit_login).
      and_return(params)

    allow_any_instance_of(RedditAuthService).
      to receive(:request_user_token).
      and_return("1234")

    allow_any_instance_of(RedditAuthService).
      to receive(:request_user_information).
      and_return(user_hash)

    allow_any_instance_of(ApplicationController).
      to receive(:user_subreddits).
      and_return([Subreddit.new(display_name: "programming")])

    visit "/"
    click_on "Login with Reddit"

    # User is created as part of the login process
    user = User.last

    expect(current_path).to eq(root_path)
    expect(user.username).to eq("test")
    expect(user.token).to eq("1234")
    expect(page).to have_content("Successfully logged in!")
    expect(page).to have_link("logout")
    expect(page).to_not have_link("Login with Reddit")
  end
end
