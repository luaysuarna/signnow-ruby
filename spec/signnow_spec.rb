require "spec_helper"

describe Signnow do
  describe ".request" do
    context "given no api key exists" do
      it "raises an authentication error" do
        expect { Signnow.request(:get, nil, "clients", {}) }.to raise_error(Signnow::AuthenticationError)
      end
    end

    context "with an invalid api key" do
      before(:each) do
        Signnow.api_key = "_your_api_key_"
        WebMock.stub_request(:any, /#{Signnow::API_BASE}/).to_return(:body => "{}")
      end

      it "attempts to get a url with one param" do
        Signnow.request(:get, nil, "user", { param_name: "param_value" })
        WebMock.should have_requested(:get, "https://#{Signnow::DOMAIN_BASE}.#{Signnow::API_BASE}/#{Signnow::API_BASE_PATH}/user/?param_name=param_value")
      end

      it "attempts to get a url with more than one param" do
        Signnow.request(:get, nil, "user", { client: "client_id", order: "created_at_desc" })
        WebMock.should have_requested(:get, "https://#{Signnow::DOMAIN_BASE}.#{Signnow::API_BASE}/#{Signnow::API_BASE_PATH}/user/?client=client_id&order=created_at_desc")
      end

      it "doesn't add a question mark if no params" do
        Signnow.request(:get, nil, "user", {})
        WebMock.should have_requested(:get, "https://#{Signnow::DOMAIN_BASE}.#{Signnow::API_BASE}/#{Signnow::API_BASE_PATH}/user/")
      end
    end
  end
end
