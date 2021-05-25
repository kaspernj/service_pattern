class TestService < ServicePattern::Service
  attr_reader :chained_failing_service, :empty_result, :should_fail_on_execute

  def initialize(chained_failing_service: false, empty_result: false, should_fail_on_execute: false)
    @chained_failing_service = chained_failing_service
    @empty_result = empty_result
    @should_fail_on_execute = should_fail_on_execute
  end

  def perform
    return ChainedFailingService.chain if chained_failing_service

    fail! "should fail on execute" if should_fail_on_execute
    succeed!
  end
end
