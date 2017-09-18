# ServicePattern

Easy callback service pattern for Ruby on Rails.

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem "service_pattern"
```

Create an application service that your other services will enherit from in "app/services/application_service":
```ruby
class ApplicationService < ServicePattern::Service
end
```

Create your first service in "app/services/users/activator_service":
```ruby
class Users::ActivatorService < ApplicationService
  def execute!
    User.all.find_each(&:activate!)
    ServicePattern::Response.new(success: true)
  end
end
```

Then call it like this:
```ruby
response = Users::ActivatorService.()

if response.success?
  puts "Wee"
else
  puts "Errors: #{result.errors.join(". ")}"
end
```

### Returning results

You can also return a result, which will automatically make the response successfull:
```ruby
ServicePattern::Response.new(result: {message: "Hello world"})
```

You can then retrieve it like this:
```ruby
response = Users::ActivatorService.()
puts "Result: #{response.result}"
```

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
