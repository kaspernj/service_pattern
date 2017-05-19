class CantExecuteService < ServicePattern::Service
  def can_execute?
    return ServicePattern::Response.new(errors: ["can execute false"])
    ServicePattern::Response.new(success: true)
  end

  def execute!
    ServicePattern::Response.new(errors: ["shouldnt execute"])
  end
end
