require "rails_helper"

describe ServicePattern::Service do
  describe "#can_execute?" do
    it "doesnt succeed when calling" do
      response = CantExecuteService.()

      expect(response.success?).to eq false
      expect(response.errors).to eq ["shouldnt execute"]
    end

    it "raises an exception when calling execute!" do
      expect do
        CantExecuteService.execute!
      end.to raise_error(ServicePattern::FailedError)
    end
  end
end
