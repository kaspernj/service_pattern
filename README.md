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
  def execute
    User.all.find_each(&:activate!)
    succeed!
  end
end
```

Then call it like this:
```ruby
response = Users::ActivatorService.()

if response.success?
  puts "Result: #{response.result}"
else
  puts "Errors: #{response.errors.join(". ")}"
end
```

Or like this:
```ruby
response = Users::ActivatorService.execute()

if response.success?
  puts "Result: #{response.result}"
else
  puts "Errors: #{response.errors.join(". ")}"
end
```

Or raise an error if it fails and return the result directly:
```ruby
result = Users::ActivatorService.execute!

puts "Result: #{result}"
```

### Returning results

You can also return a result, which will automatically make the response successfull:
```ruby
succeed!(message: "Hello world")
```

You can then retrieve it like this:
```ruby
response = Users::ActivatorService.()
puts "Result: #{response.result}"
```

You can fail a service like this
```ruby
fail! "Hello world"
```

Or with multiple errors:
```ruby
fail! ["Hello world", "Hello again"]
```

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
