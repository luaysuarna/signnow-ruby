require "spec_helper"

describe Signnow::Request::Connection do
  before :each do
    Signnow.api_key = "_your_signnow_api_key_"
  end

  describe "#setup_https" do
    it "creates a https object" do
      connection = Signnow::Request::Connection.new(nil)

      connection.setup_https

      connection.https.should_not be_nil
    end
  end

  describe "#request" do
    it "performs the actual request" do
      connection = Signnow::Request::Connection.new(nil)
      connection.setup_https
      connection.stub(:https_request)

      connection.https.should_receive(:request)

      connection.request
    end
  end

  describe "#https_request" do
    it "correctly formats the form data" do
      info = double(
        http_method: :post,
        url: "/some/path",
        data: params,
        subdomain: Signnow::DOMAIN_BASE,
        authentication: {
          type: :basic
        }
      )
      connection = Signnow::Request::Connection.new(info)
      connection.setup_https

      connection.__send__(:https_request).body.downcase.should eq(%{{\"email\":\"abc_abc.com\",\"event_types[0]\":\"user.created\",\"event_types[1]\":\"user.failed\",\"event_types[2]\":\"team.created\",\"event_types[3]\":\"documents.available\"}})
    end
  end

  def params
    {
      email: "abc_abc.com",
      event_types: ["user.created","user.failed", "team.created", "documents.available"]
    }
  end
end
