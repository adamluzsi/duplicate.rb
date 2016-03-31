# Duplicate

Duplicate is Originally extracted from rack-app project. 
Allows you to Deep duplicate any ruby objects in pure ruby way. 
That way you can recursively duplicate objects and even replacing original object references with in instance variable references

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'duplicate'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install duplicate

## Usage

```ruby
Duplicate.duplicate('Hello, world!') #> returns duplication
Duplicate.duplicate(Class.new) #> returns duplication
```

or with syntax sugar

```ruby
duplicate(Object.new) #> return duplication
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/duplicate. 
This project is intended to be a safe, welcoming space for collaboration, 
and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.
