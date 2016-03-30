module Subscribem
  class Account < ActiveRecord::Base
    belongs_to :owner, :class_name => "Subscribem::User"
    accepts_nested_attributes_for :owner

    EXCLUDE_SUBDOMAINS = %w(admin)

    validates :subdomain, :presence =>true, :uniqueness => true
    validates_exclusion_of :subdomain, :in => EXCLUDE_SUBDOMAINS,
      :message=> "is not allowed.Please choose another subdomain."

    validates_format_of :subdomain, :with => /\A[\w\-]+\Z/i,
      :message=> "is not allowed.Please choose another subdomain."

    before_validation do 
      self.subdomain = self.subdomain.to_s.downcase
    end
  end
end
