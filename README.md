# PunctualDateSelect

This gem provides yet another date_select-like fields which can hold invalid date data.

When using Rails's date_select, an invalid date like 2016/9/31 would be casted into 2016/10/1 with no warning.
This may cause a human error in some use cases.

With PunctualDateSelect, you can hold invalid date as they are specified by an user and show the invalid error message.
Therefore users can notice the mistakes they've made.

This gem is for Rails 4 currently.

## Key concept

Using PunctualDateSelect, your date column value won't have Date object while it is non-existing date.
It holds parameters like {year: '2016', month: '9', day: '31'} instead.
This gem extends that parameters to respond year, month, day, to_date, to_s so that inner select_date field use it like Date object.
You can use to_date or to_s in your code to get the valid date information.
If the specified date from punctual_date_select fields is collect, it will be casted into Date object before validation.

Note that you need to run validation before you save it not to send those parameters holding invalid date data to DB.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'punctual_date_select'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install punctual_date_select

## Usage

You need to write code in 2 places; Model and View.

### Model (ActiveRecord)

It your model class which has the target date column, call punctual_date_select method.

```ruby
punctual_date_column :started_on # You have started_on column which represents a date.
```

### View

On the view side, you can use punctual_date_select instead of date_select. This helper holds invalid date values so that the user can see what is wrong.
This plugin does not support non-builder type helper.

  <% form_for :your_model do |f| %>
    <%= f.punctual_date_select :started_on %>
  <% end %>

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nay/punctual_date_select.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

