after "staging:posts" do
  Post.find_each do |post|
    FactoryGirl.create_list(:comment, 3, post: post, author: post.author)
  end
end

