require "spec_helper"

describe Signnow do
  describe ".request" do
    context "given no api key exists" do
      it "raises an authentication error" do
        Signnow.configure do |config|
          config[:app_id] = nil
          config[:app_secret] = nil
        end
        expect { Signnow.request(:get, nil, "clients", {}) }.to raise_error(Signnow::AuthenticationError)
      end
    end

    context "with an invalid api key" do
      before(:each) do
        Signnow.configure do |config|
          config[:app_id] = 'my_app_id'
          config[:app_secret] = 'my_app_secret'
        end
        WebMock.stub_request(:any, /#{Signnow::API_BASE}/).to_return(:body => "{}")
      end

      it "attempts to get a url with one param" do
        Signnow.request(:get, nil, "user", { param_name: "param_value" })
        WebMock.should have_requested(:get, "https://#{Signnow::DOMAIN_BASE}.#{Signnow::API_BASE}/#{Signnow::API_BASE_PATH}/user?param_name=param_value")
      end

      it "attempts to get a url with more than one param" do
        Signnow.request(:get, nil, "user", { client: "client_id", order: "created_at_desc" })
        WebMock.should have_requested(:get, "https://#{Signnow::DOMAIN_BASE}.#{Signnow::API_BASE}/#{Signnow::API_BASE_PATH}/user?client=client_id&order=created_at_desc")
      end

      it "doesn't add a question mark if no params" do
        Signnow.request(:post, nil, "user", {})
        WebMock.should have_requested(:post, "https://#{Signnow::DOMAIN_BASE}.#{Signnow::API_BASE}/#{Signnow::API_BASE_PATH}/user")
      end

      it "uses correct authentication header if basic auth is setted" do
        Signnow.request(:post, nil, "user", {id: 'new_id'}, { auth_type: :basic })
        WebMock.should have_requested(:post, "https://#{Signnow.configuration[:app_id]}:#{Signnow.configuration[:app_secret]}@#{Signnow::DOMAIN_BASE}.#{Signnow::API_BASE}/#{Signnow::API_BASE_PATH}/user/new_id")
      end
    end
  end
end
