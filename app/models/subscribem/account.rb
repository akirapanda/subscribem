module Subscribem
  class Account < ActiveRecord::Base
    belongs_to :owner, :class_name => "Subscribem::User"
    accepts_nested_attributes_for :owner

    has_many :members, :class_name => "Subscribem::Member"
    has_many :users, :through => :members


    EXCLUDE_SUBDOMAINS = %w(admin)

    validates :subdomain, :presence =>true, :uniqueness => true
    validates_exclusion_of :subdomain, :in => EXCLUDE_SUBDOMAINS,
      :message=> "is not allowed.Please choose another subdomain."

    validates_format_of :subdomain, :with => /\A[\w\-]+\Z/i,
      :message=> "is not allowed.Please choose another subdomain."





    before_validation do 
      self.subdomain = self.subdomain.to_s.downcase
    end


    def self.create_with_owner(params={})
      account = new(params)
      if account.save
        account.users << account.owner
      end
      account
    end

  end
end
