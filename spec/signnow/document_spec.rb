require "spec_helper"

describe Signnow::Document do
  let(:valid_attributes) do
      JSON.parse %{
        {
            "id": "9e30bb3094e00abc291016a7a597ba1840a6d6ec",
            "user_id": "adb16da39e5ecc448e2aa4aec8a34a8158fa137a",
            "document_name": "sample.pdf",
            "page_count": "1",
            "created": "1358300444",
            "updated": "1358300444",
            "original_filename": "sample.pdf",
            "thumbnail": {
                "small": "https:\/\/api.signnow.com\/document\/9e30bb3094e00abc291016a7a597ba1840a6d6ec\/thumbnail?size=small",
                "medium": "https:\/\/api.signnow.com\/document\/9e30bb3094e00abc291016a7a597ba1840a6d6ec\/thumbnail?size=medium",
                "large": "https:\/\/api.signnow.com\/document\/9e30bb3094e00abc291016a7a597ba1840a6d6ec\/thumbnail?size=large"
            },
            "signatures": [],
            "seals": [],
            "texts": [],
            "inserts": [],
            "tags": [],
            "fields": [],
            "requests": [],
            "notary_invites": [],
            "version_time": "1358300444"
        }
      }
  end

  let(:valid_all_response) do
    JSON.parse %{
        [{
            "id": "9e30bb3094e00abc291016a7a597ba1840a6d6ec",
            "user_id": "adb16da39e5ecc448e2aa4aec8a34a8158fa137a",
            "document_name": "sample.pdf",
            "page_count": "1",
            "created": "1358300444",
            "updated": "1358300444",
            "original_filename": "sample.pdf",
            "thumbnail": {
                "small": "https:\/\/api.signnow.com\/document\/9e30bb3094e00abc291016a7a597ba1840a6d6ec\/thumbnail?size=small",
                "medium": "https:\/\/api.signnow.com\/document\/9e30bb3094e00abc291016a7a597ba1840a6d6ec\/thumbnail?size=medium",
                "large": "https:\/\/api.signnow.com\/document\/9e30bb3094e00abc291016a7a597ba1840a6d6ec\/thumbnail?size=large"
            },
            "signatures": [],
            "seals": [],
            "texts": [],
            "inserts": [],
            "tags": [],
            "fields": [],
            "requests": [],
            "notary_invites": [],
            "version_time": "1358300444"
        }, {
            "id": "321e1c74ada708f442bf3f9529ed0d44b3628796",
            "user_id": "adb16da39e5ecc448e2aa4aec8a34a8158fa137a",
            "document_name": "sample.pdf",
            "page_count": "1",
            "created": "1341248871",
            "updated": "1341248871",
            "original_filename": "sample.pdf",
            "thumbnail": {
                "small": "https:\/\/api.signnow.com\/document\/321e1c74ada708f442bf3f9529ed0d44b3628796\/thumbnail?size=small",
                "medium": "https:\/\/api.signnow.com\/document\/321e1c74ada708f442bf3f9529ed0d44b3628796\/thumbnail?size=medium",
                "large": "https:\/\/api.signnow.com\/document\/321e1c74ada708f442bf3f9529ed0d44b3628796\/thumbnail?size=large"
            },
            "signatures": [],
            "seals": [],
            "texts": [],
            "inserts": [],
            "tags": [],
            "fields": [],
            "requests": [{
                "unique_id": "1cb9d8e6b26d6ececc4f4c9d08aaaa28e10fa80f",
                "id": "1cb9d8e6b26d6ececc4f4c9d08aaaa28e10fa80f",
                "user_id": "adb16da39e5ecc448e2aa4aec8a34a8158fa137a",
                "created": "1349903957",
                "originator_email": "user@test.com",
                "signer_email": "signer@test.com"
            }],
            "notary_invites": [],
            "version_time": "1341248871"
        }, {
            "id": "1db4c6ba33332f655cb2eda468743c1d040ae079",
            "user_id": "adb16da39e5ecc448e2aa4aec8a34a8158fa137a",
            "document_name": "sample.pdf",
            "page_count": "1",
            "created": "1335819071",
            "updated": "1335819071",
            "original_filename": "sample.pdf",
            "thumbnail": {
                "small": "https:\/\/api.signnow.com\/document\/1db4c6ba33332f655cb2eda468743c1d040ae079\/thumbnail?size=small",
                "medium": "https:\/\/api.signnow.com\/document\/1db4c6ba33332f655cb2eda468743c1d040ae079\/thumbnail?size=medium",
                "large": "https:\/\/api.signnow.com\/document\/1db4c6ba33332f655cb2eda468743c1d040ae079\/thumbnail?size=large"
            },
            "signatures": [],
            "seals": [],
            "texts": [],
            "inserts": [],
            "tags": [],
            "fields": [],
            "requests": [{
                "unique_id": "5d8ce45d8e27c7ed717d7d23117200c72442ee3e",
                "id": "5d8ce45d8e27c7ed717d7d23117200c72442ee3e",
                "user_id": "adb16da39e5ecc448e2aa4aec8a34a8158fa137a",
                "created": "1335819085",
                "originator_email": "jane@test.com",
                "signer_email": "signer@test.com"
            }],
            "notary_invites": [],
            "version_time": "1335819071"
        }]
    }
  end

  let (:document) do
    Signnow::Document.new(valid_attributes)
  end

  let(:user_access_token) { '_user_access_token_' }

  describe "#initialize" do
    it 'initializes all attributes correctly' do
      document.id.should eql('9e30bb3094e00abc291016a7a597ba1840a6d6ec')
      document.user_id.should eql('adb16da39e5ecc448e2aa4aec8a34a8158fa137a')
      document.document_name.should eql('sample.pdf')
      document.page_count.should eql('1')
      document.original_filename.should eql('sample.pdf')
    end
  end

  describe ".show" do
    let(:document_show) { Signnow::Document.show(access_token: user_access_token, id: document.id ) }
    before :each do
      allow(Signnow).to receive(:request).and_return(valid_attributes)
    end
    it "makes a new GET request using the correct API endpoint to receive a specific user" do
      expect(Signnow).to receive(:request).with(:get, nil, "document/#{document.id}", {}, { auth_type: :user_token, auth_token: user_access_token })
      document_show
    end
    it 'returns a user with the correct id' do
      expect(document_show.id).to eql('9e30bb3094e00abc291016a7a597ba1840a6d6ec')
    end
    it 'returns a user with the correct document_name' do
      expect(document_show.document_name).to eql('sample.pdf')
    end
    it 'returns a user with the correct original_filename' do
      expect(document_show.original_filename).to eql('sample.pdf')
    end
  end

  describe ".download_link" do
    let(:document_download_link) { Signnow::Document.download_link(access_token: user_access_token, id: document.id ) }
    let(:valid_link_attributes) do
      { 'link' => 'https://signnow.com/dispatch?route=onetimedownload&document_download_id=67de624701a70cdfe208b5c537f61fefa48b410a' }
    end
    before :each do
      allow(Signnow).to receive(:request).and_return(valid_link_attributes)
    end
    it "makes a new GET request using the correct API endpoint to receive a specific user" do
      expect(Signnow).to receive(:request).with(:get, nil, "document/#{document.id}/download/link", {}, { auth_type: :user_token, auth_token: user_access_token })
      document_download_link
    end
    it 'returns a user with the correct link' do
      expect(document_download_link).to eql('https://signnow.com/dispatch?route=onetimedownload&document_download_id=67de624701a70cdfe208b5c537f61fefa48b410a')
    end
  end

  describe ".all" do
    let(:document_all) { Signnow::Document.all(access_token: user_access_token) }
    before :each do
      allow(Signnow).to receive(:request).and_return(valid_all_response)
    end
    it "makes a new POST request using the correct API endpoint" do
      expect(Signnow).to receive(:request).with(:get, nil, "user/documentsv2", {}, { auth_type: :user_token, auth_token: user_access_token })
      document_all
    end
    it 'returns a user with the correct id' do
      expect(document_all.first.id).to eql('9e30bb3094e00abc291016a7a597ba1840a6d6ec')
    end
  end
end
