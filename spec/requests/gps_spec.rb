# spec/requests/gps_spec.rb
require "rails_helper"

RSpec.describe "GPS API", type: :request do
  subject { post request_path, params: params }

  # init test data
  let(:request_path) { "/api/v1/gps" }
  let!(:waypoint_1) { create(:waypoint) }
  let!(:waypoint_2) { create(:waypoint) }

  # Test suite for POST on gps endpoint
  describe "POST /api/v1/gps" do
    context "when request params is an array" do
      let(:params) { { _json: [waypoint_1, waypoint_2] } }

      it "returns status code 201" do
        subject
        expect(response).to have_http_status(:created)
      end
    end

    context "when request params is an object" do
      let(:params) do
        {
          latitude: 123,
          longitude: 321,
          sent_at: Time.now - 5.minutes.ago,
          vehicle_identifier: waypoint_1.vehicle_id,
        }
      end

      it "returns status code 201" do
        subject
        expect(response).to have_http_status(:created)
      end
    end

    context "when request params is invalid" do
      let(:params) { { no_valid_param: true } }

      it "returns status code 422" do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when request params is empty" do
      let(:params) {}

      it "returns status code 422" do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
