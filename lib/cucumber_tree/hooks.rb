require "cucumber/rspec/doubles"

module Capybara
  class Session
    def cookies
      @cookies ||= begin
        secret = Rails.application.config.secret_token
        cookies = ActionDispatch::Cookies::CookieJar.new(secret)
        cookies.stub(:close!)
        cookies
      end
    end
  end
end

Before do |scenario|
  stub_cookies(page)
  CucumberTree.load_snapshot(self, scenario)
end

After do |scenario|
  CucumberTree.save_snapshot(self, scenario)
end

AfterConfiguration do
  CucumberTree.setup
end

def stub_cookies(page)
  request = ActionDispatch::Request.any_instance
  request.stub(:cookie_jar).and_return{ page.cookies }
  request.stub(:cookies).and_return{ page.cookies }
end
