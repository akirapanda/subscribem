module Subscribem
  class Account::DashboardController < ApplicationController
    before_filter :authenticate_user!
    def index

    end
  end
end
