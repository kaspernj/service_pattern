class Service
  include AwesomeTranslations::TranslateFunctionality

  def self.call(*args)
    service = new(*args)

    begin
      return service.execute!
    rescue => e
      ServiceResponse.new(errors: ["#{e.class.name}: #{e.message}"], success: false)
    end
  end

  def self.execute!(*args)
    new(*args).execute!
  end
end
