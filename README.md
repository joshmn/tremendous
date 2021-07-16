# Tremendous

Ruby API client for [Tremendous.com](https://tremendous.com).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tremendous'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install tremendous

## Usage

Grab your API key and configure your client:

```ruby
Tremendous.configure do |config|
  config.endpoint = "https://testflight.tremendous.com"
  config.api_key = "TEST_longtokenstring"
end
```

## Rewards

### Retrieve

```ruby
reward = Tremendous::Reward.retrieve(id)
reward.id 
...
```

### List

```ruby
rewards = Tremendous::Reward.list
rewards.each do |reward|
  puts reward.id 
end
```

## Organizations

### Retrieve

```ruby
organization = Tremendous::Organization.retrieve(id)
organization.id 
...
```

### Create

```ruby
params = {}
Tremendous::Organization.create(params)
```

### List

```ruby
organizations = Tremendous::Organization.list
organizations.each do |organization|
  puts organization.id 
end
```

## Products

### List

```ruby
products = Tremendous::Product.list
products.each do |product|
  puts product.id 
end

```

## Fields

### List

```ruby
fields = Tremendous::Field.list
fields.each do |field|
  puts field.id 
end
```

## Campaigns

### List

```ruby
campaigns = Tremendous::Campaign.list
campaigns.each do |campaign|
  puts campaign.id 
end

```

## Funding Sources

### Retrieve

```ruby
funding_source = Tremendous::FundingSource.retrieve(id)
funding_source.id 
...
```

### List

```ruby
funding_sources = Tremendous::FundingSource.list
funding_sources.each do |funding_source|
  puts funding_source.id 
end
```

## Invoices

### Retrieve

```ruby
invoice = Tremendous::Invoice.retrieve(id)
invoice.id 
...
```

### Destroy

```ruby
Tremendous::Invoice.destroy(id)
```

### Create

```ruby
params = {}
Tremendous::Invoice.create(params)
```

### List

```ruby
invoices = Tremendous::Invoice.list
invoices.each do |invoice|
  puts invoice.id 
end
```

## Members

### Retrieve

```ruby
member = Tremendous::Member.retrieve(id)
member.id 
...
```

### Create

```ruby
params = {}
Tremendous::Member.create(params)
```

### List

```ruby
members = Tremendous::Member.list
members.each do |member|
  puts member.id 
end
```

## Orders

### Retrieve

```ruby
order = Tremendous::Order.retrieve(id)
order.id 
...
```

### Create

```ruby
params = {}
Tremendous::Order.create(params)
```

### List

```ruby
orders = Tremendous::Order.list
orders.each do |order|
  puts order.id 
end
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in this project's codebase, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/joshmn/tremendous/blob/master/CODE_OF_CONDUCT.md).
