# spec/workers/store_waypoint_spec.rb
require "rails_helper"

RSpec.describe StoreWaypoint, type: :worker do
  before { described_class.jobs.clear }
  subject { described_class.perform_async(latitude, longitude, sent_at, vehicle_identifier) }

  #init test data
  let!(:existing_vehicle) { create(:vehicle) }
  let(:latitude) { -33 }
  let(:longitude) { -70 }
  let(:sent_at) { Time.zone.now - 5.minutes }
  let(:vehicle_identifier) { existing_vehicle.identifier }

  let(:waypoint_1) { build(:waypoint) }
  let(:waypoint_with_uncreated_vehicle) do
    {
      latitude: -30,
      longitude: -70,
      sent_at: Time.zone.now - 5.minutes,
      vehicle_identifier: "I_SHOULD_NOT_EXISTS",
    }
  end

  describe "general behavior" do
    it "enques a job?" do
      expect { described_class.perform_async }.to change(described_class.jobs, :size).by(1)
    end

    it "executes a job?" do
      described_class.drain
      assert_equal 0, described_class.jobs.size
    end
  end

  describe "proccess a waypoint" do
    context "receives valid parameters" do
      it "should add a new Waypoint" do
        Sidekiq::Testing.inline! do
          expect { subject }.to change(Waypoint, :count).by(1)
        end
      end

      context "with uncreated vehicle" do
        let(:vehicle_identifier) { "I_SHOULD_NOT_EXISTS" }

        it "should add a new vehicle" do
          Sidekiq::Testing.inline! do
            expect { subject }.to change(Vehicle, :count).by(1)
          end
        end

        it "should add a new waypoint" do
          Sidekiq::Testing.inline! do
            expect { subject }.to change(Waypoint, :count).by(1)
          end
        end
      end
    end

    context "receives invalid parameters" do
      let(:vehicle_identifier) { nil }

      it "should raise exception" do
        Sidekiq::Testing.inline! do
          expect { subject }.to raise_error(ActiveRecord::RecordNotSaved)
        end
      end
    end
  end
end
