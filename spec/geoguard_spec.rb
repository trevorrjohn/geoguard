RSpec.describe GeoGuard do
  it "has a version number" do
    expect(GeoGuard::VERSION).not_to be nil
  end

  it "allows configuration to be set" do
    GeoGuard.configure do |c|
      c.client_id = :client_id
      c.license = :license
      c.format = :MMDB
      c.host = 'https://updates.geoguard.com'
    end
    expect(GeoGuard.configuration.client_id).to eq :client_id
    expect(GeoGuard.configuration.license).to eq :license
    expect(GeoGuard.configuration.format).to eq :MMDB
    expect(GeoGuard.configuration.host).to eq 'https://updates.geoguard.com'
  end

  it "builds the url and gets the request" do
    GeoGuard.configure do |c|
      c.client_id = :client_id
      c.license = :license
      c.format = :MMDB
      c.host = 'https://updates.geoguard.com'
    end
    body = double :body
    response = double 'RestClient::Response', body: body, code: 200
    allow(RestClient).to receive(:get).and_return(response)
    expect(GeoGuard.update).to eq body
    expect(RestClient).to have_received(:get).with(
      "https://updates.geoguard.com/v1/update/MMDB/geostream", {
        'X-Geostream-License-Key' => :license,
        'X-Geostream-Client-Id' => :client_id
    })
  end

  it "builds the url and gets the request with cache headers" do
    GeoGuard.configure do |c|
      c.client_id = :client_id
      c.license = :license
      c.format = :MMDB
      c.host = 'https://updates.geoguard.com'
    end
    body = double :body
    response = double 'RestClient::Response', body: body, code: 200
    allow(RestClient).to receive(:get).and_return(response)
    cache_headers = { 'If-Modified-Since' => 'Wed, 21 Oct 2015 07:28:00 GMT' }
    expect(GeoGuard.update(cache_headers: cache_headers)).to eq body
    expect(RestClient).to have_received(:get).with(
      "https://updates.geoguard.com/v1/update/MMDB/geostream", {
        'X-Geostream-License-Key' => :license,
        'X-Geostream-Client-Id' => :client_id,
        'If-Modified-Since' => 'Wed, 21 Oct 2015 07:28:00 GMT'
    })
  end
end
