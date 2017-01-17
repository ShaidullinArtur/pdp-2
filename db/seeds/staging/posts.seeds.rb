after "staging:users" do
  User.find_each do |user|
    FactoryGirl.create_list(:post, 3, author: user, company: user.company)
  end
end

