FactoryGirl.define  do
  factory :account, :class=> "Subscribem::Account" do
    sequence(:name) { |n| "Test Account ##{n}"} # Test Accont #1 / #2 / #3
    sequence(:subdomain) { |n| "test#{n}"}
    association :owner, :factory => :user

    after(:create) do |account|
      account.users << account.owner
    end
  end
end