class CantExecuteService < ServicePattern::Service
  def can_execute?
    ServicePattern::Response.new(errors: ["can execute false"])
  end

  def perform
    ServicePattern::Response.new(errors: ["shouldnt execute"])
  end
end
