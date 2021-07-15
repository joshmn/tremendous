

RSpec.describe Tremendous do
  it "has a version number" do
    expect(Tremendous::VERSION).not_to be nil
  end

  it "generates fixtures lol" do
    if ENV['CREATE_FIXTURES']
      members = Tremendous::Member.list
      Tremendous::Member.retrieve(members.first.id)
      funding_sources = Tremendous::FundingSource.list
      orgs = Tremendous::Organization.list
      orgs = Tremendous::Organization.retrieve(orgs.first.id)
      rewards = Tremendous::Reward.list
      rewards = Tremendous::Reward.retrieve(rewards.first.id)

      puts rewards.inspect
      campaigns = Tremendous::Campaign.list
      puts campaigns.inspect
      products = Tremendous::Product.list
      puts products.inspect
      order = Tremendous::Order.create({
                                         "external_id": "OPTIONAL ID FROM CLIENT SYSTEM",
                                         "payment": {
                                           "funding_source_id": funding_sources.first.id
                                         },
                                         "reward": {
                                           "value": {
                                             "denomination": 30,
                                             "currency_code": "USD"
                                           },
                                           "campaign_id": campaigns.first.id,
                                           "recipient": {
                                             "name": "Denise Miller",
                                             "email": "j@josh.mn"
                                           },
                                           "delivery": {
                                             "method": "EMAIL",
                                             "meta": {}
                                           }
                                         }
                                       })
      puts order.inspect
      Tremendous::Order.retrieve(order.id)
      invoice = Tremendous::Invoice.create({
                                             "po_number": "[ID FROM CLIENT]",
                                             "amount": 2000
                                           })

      puts invoice.inspect
    end

  end
end
