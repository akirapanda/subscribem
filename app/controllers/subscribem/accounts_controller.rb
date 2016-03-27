module Subscribem
  class AccountsController < ApplicationController
    def new
      @account = Subscribem::Account.new
      @account.build_owner
    end


    def create
      account = Subscribem::Account.create(account_params)
      flash[:success] = "Signed in as #{account.owner.email}."
      redirect_to subscribem.root_url
    end

    private 
    def account_params
      params.require(:account).permit!
    end
  end
end
