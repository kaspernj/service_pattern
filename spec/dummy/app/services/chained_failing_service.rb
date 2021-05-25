class ChainedFailingService < ServicePattern::Service
  def perform
    fail! "Chained fail"
  end
end
