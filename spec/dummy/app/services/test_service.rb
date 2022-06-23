class TestService < ServicePattern::Service
  argument :chained_failing_service, default: false
  argument :empty_result, default: false
  argument :should_fail_on_execute, default: false

  def perform
    return ChainedFailingService.chain if chained_failing_service

    fail! "should fail on execute" if should_fail_on_execute
    succeed!
  end
end
