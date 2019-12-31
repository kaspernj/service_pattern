require "rails_helper"

describe ServicePattern::Service do
  describe "#can_execute?" do
    it "doesnt succeed when calling" do
      response = CantExecuteService.()

      expect(response.success?).to eq false
      expect(response.errors).to eq ["can execute false"]
    end

    it "raises an exception when calling execute!" do
      expect do
        CantExecuteService.execute!
      end.to raise_error(ServicePattern::FailedError)
    end
  end

  it "succeeds" do
    response = TestService.execute

    expect(response.success?).to eq true
    expect(response.errors).to eq []
  end

  it "succeeds even if the result is empty" do
    response = TestService.execute(empty_result: true)
    expect(response.success?).to eq true
  end

  it "fails on execute" do
    response = TestService.execute(should_fail_on_execute: true)

    expect(response.success?).to eq false
    expect(response.errors).to eq ["should fail on execute"]
  end

  it "fails when a chained failing service fails" do
    response = TestService.execute(chained_failing_service: true)

    expect(response.errors).to eq ["Chained fail"]
    expect(response.success?).to eq false
  end
end
