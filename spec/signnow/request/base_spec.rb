require "spec_helper"

describe Signnow::Request::Base do
  context "#perform" do
    it "checks for an api key" do
      Signnow.stub(:encoded_app_credentials).and_return(nil)

      expect{
        Signnow::Request::Base.new(nil).perform
      }.to raise_error Signnow::AuthenticationError
    end

    it "performs an https request" do
      Signnow.stub(:encoded_app_credentials).and_return("some key")
      connection = double
      validator  = double
      Signnow::Request::Connection.stub(:new).and_return(connection)
      Signnow::Request::Validator.stub(:new).and_return(validator)

      connection.should_receive(:setup_https)
      connection.should_receive(:request)
      validator.should_receive(:validated_data_for)

      Signnow::Request::Base.new(nil).perform
    end
  end
end
