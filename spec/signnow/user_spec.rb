require "spec_helper"

describe Signnow::User do
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

  let (:user) do
    Signnow::User.new(valid_attributes)
  end

  describe "#initialize" do
    it 'initializes all attributes correctly' do
      user.email.should eql('hola+test@andresbravo.com')
      user.id.should eql('23f2f9dc10e0f12883f78e91296207640dede6d1')
      user.first_name.should eql('Test')
      user.last_name.should eql('User')
      user.active.should eql(true)
      user.type.should eql(1)
      user.pro.should eql(false)
    end
  end

  describe ".show" do
    it "makes a new GET request using the correct API endpoint to receive a specific user" do
      Signnow.should_receive(:request).with(:get, nil, "user", {}).and_return("data" => {})
      Signnow::User.show
    end
  end

  describe ".create" do
    it "makes a new POST request using the correct API endpoint" do
      Signnow.should_receive(:request).with(:post, nil, "user", valid_attributes).and_return("data" => {})
      Signnow::User.create(valid_attributes)
    end
  end
end
