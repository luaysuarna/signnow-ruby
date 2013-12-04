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

  let(:valid_create_response) do
    JSON.parse %{
      {\"id\":\"d0a68ff1d605e23148b411a9405de65b5fff12af\",\"verified\":0,\"email\":\"test@andresbravo.com\"}
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
    before :each do
      allow(Signnow).to receive(:request).and_return(valid_attributes)
    end
    it "makes a new GET request using the correct API endpoint to receive a specific user" do
      expect(Signnow).to receive(:request).with(:get, nil, "user", {}, { auth_type: :user_token })
      Signnow::User.show
    end
    it 'returns a user with the correct id' do
      expect(Signnow::User.show.id).to eql('23f2f9dc10e0f12883f78e91296207640dede6d1')
    end
    it 'returns a user with the correct first_name' do
      expect(Signnow::User.show.first_name).to eql('Test')
    end
    it 'returns a user with the correct last_name' do
      expect(Signnow::User.show.last_name).to eql('User')
    end
  end

  describe ".create" do
    before :each do
      allow(Signnow).to receive(:request).and_return(valid_create_response)
    end
    it "makes a new POST request using the correct API endpoint" do
      expect(Signnow).to receive(:request).with(:post, nil, "user", valid_attributes, { auth_type: :basic })
      Signnow::User.create(valid_attributes)
    end
    it 'returns a user with the correct id' do
      expect(Signnow::User.show.id).to eql('d0a68ff1d605e23148b411a9405de65b5fff12af')
    end
  end
end
