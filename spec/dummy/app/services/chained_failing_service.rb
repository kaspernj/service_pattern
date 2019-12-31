class ChainedFailingService < ServicePattern::Service
  def execute
    fail! "Chained fail"
  end
end
