module Companies
  class BaseController < ApplicationController
    include CompanyAuthentication

    layout "company"
  end
end
