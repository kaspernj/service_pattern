require "rails_helper"

describe ServicePattern::Service do
  describe "#can_execute?" do
    it "doesnt succeed when calling" do
      response = CantExecuteService.()

      expect(response.success?).to eq false
      expect(response.errors).to eq ["can execute false"]
    end

    it "raises an exception when calling execute!" do
      expect { CantExecuteService.execute! }.to raise_error(ServicePattern::FailedError)
    end

    it "includes a usable stack trace" do
      error = nil
      begin
        FailService.execute!
      rescue => e # rubocop:disable Style/RescueStandardError
        error = e
      end

      match = error.backtrace.select { |trace| trace.include?("spec/dummy/app/services/fail_service.rb") }
      expect(match.length).to eq 1
    end
  end

  describe "#fail!" do
    it "fails with a message and a type" do
      service_class = Class.new(ServicePattern::Service) do
        def execute
          fail! "Test", type: :custom_type
        end
      end

      response = service_class.execute

      expect(response.error_messages).to eq ["Test"]
      expect(response.error_types).to eq [:custom_type]
    end

    it "fails with a message and a type through a raise error" do
      service_class = Class.new(ServicePattern::Service) do
        def execute
          fail! "Test", type: :custom_type
        end
      end

      begin
        service_class.execute!
        raise "Didn't expect to reach this"
      rescue ServicePattern::FailedError => e
        expect(e.error_messages).to eq ["Test"]
        expect(e.error_types).to eq [:custom_type]
      end
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
    expect(response.error_messages).to eq ["should fail on execute"]
    expect(response.error_types).to eq []
  end

  it "fails when a chained failing service fails" do
    response = TestService.execute(chained_failing_service: true)

    expect(response.error_messages).to eq ["Chained fail"]
    expect(response.error_types).to eq []
    expect(response.success?).to eq false
  end
end
