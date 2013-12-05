require "spec_helper"

describe Signnow::Client do
  let(:valid_attributes) do
      JSON.parse %{
        {
          "id": "23f2f9dc10e0f12883f78e91296207640dede6d1",
          "first_name": "Test",
          "last_name": "User",
          "active": "1",
          "type": 1,
          "pro": 0,
          "created": "1358945328",
          "emails": ["hola+test@andresbravo.com"],
          "identity": {
              "Identified": "No",
              "Status": "First attempt",
              "OKToRetry": true
          },
          "subscriptions": [],
          "credits": 0,
          "has_atticus_access": false,
          "is_logged_in": true,
          "teams": []
        }
      }
  end

  let (:client) do
    Signnow::Client.new(user_access_token)
  end

  let(:user_access_token) { '_user_access_token_' }

  describe "#initialize" do
    it 'initializes attributes correctly' do
      client.access_token.should eql(user_access_token)
    end
  end

  describe "#perform!" do
    before :each do
      allow(Signnow).to receive(:request).and_return(valid_attributes)
    end
    it "executes requests inside the block" do
      expect(Signnow).to receive(:request).with(:get, nil, "user", {}, { auth_type: :user_token, auth_token: user_access_token })
      client.perform! do |token|
        Signnow::User.show(access_token: token)
      end
    end
  end

end
