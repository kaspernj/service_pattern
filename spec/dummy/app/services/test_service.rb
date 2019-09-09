class TestService < ServicePattern::Service
  attr_reader :chained_failing_service, :should_fail_on_execute

  def initialize(chained_failing_service: false, should_fail_on_execute: false)
    @chained_failing_service = chained_failing_service
    @should_fail_on_execute = should_fail_on_execute
  end

  def execute
    ChainedFailingService.chain if chained_failing_service
    return ServicePattern::Response.new(errors: ["should fail on execute"]) if should_fail_on_execute

    ServicePattern::Response.new(success: true)
  end
end
