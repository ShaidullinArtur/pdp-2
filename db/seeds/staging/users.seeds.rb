after "staging:companies" do
  Company.find_each do |company|
    FactoryGirl.create_list(:user, 3, subdomain: company.subdomain)
  end
end

