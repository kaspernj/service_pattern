class TestService < ServicePattern::Service
  arguments :chained_failing_service, :empty_result, :should_fail_on_execute

  def perform
    return ChainedFailingService.chain if chained_failing_service

    fail! "should fail on execute" if should_fail_on_execute
    succeed!
  end
end
