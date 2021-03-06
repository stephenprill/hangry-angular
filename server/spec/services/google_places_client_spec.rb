require "rails_helper"

describe GooglePlacesClient do
  subject { GooglePlacesClient.new('api_key') }

  describe "#find_by_location" do
    it "finds a list of restaurants" do
      allow(HTTParty).to receive(:get).and_return("results" => ['restaurant'])

      result = subject.find_by_location(latitude: 123, longitude: 321)

      expect(HTTParty).to have_received(:get).with(
                            "https://maps.googleapis.com/maps/api/place/nearbysearch/json",
                            query: {
                              key: "api_key",
                              location: "123,321",
                              radius: 1000,
                              rankby: "prominence",
                              types: "restaurant|food|bar|cafe"
                            }
                          )

      expect(result).to eq ['restaurant']
    end
  end
end