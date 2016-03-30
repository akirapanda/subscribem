Warden::Strategies.add(:password)  do

  def subdomain
    host = request.host # request is a Rack::Request
    ActionDispatch::Http::URL.extract_subdomains(host,1)
  end

  def valid?
    subdomain.present? && params["user"] # Need subdomain and user key in params
  end

  def authenticate!
    # subdomain account is not exist.
    return fail! unless account = Subscribem::Account.find_by(:subdomain=>subdomain)
    # user is not exist in account.users
    return fail! unless user = account.users.find_by(:email => params["user"]["email"])
    # Password is wrong 
    return fail! unless user.authenticate(params["user"]["password"])
    success! user
  end
end

