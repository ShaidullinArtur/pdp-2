ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Top 5 Posts" do
          table_for(Post.includes(:author).order(rating: :desc).limit(5)) do
            column :title do |post|
              link_to(post.title, admin_post_path(post))
            end
            column :author do |post|
              link_to(post.author.full_name, admin_user_path(post.author))
            end
            column :rating
          end
        end
      end

      column do
        panel "Top 5 Users" do
          table_for(User.includes(:company).order(average_rating: :desc, posts_count: :desc).limit(5)) do
            column :user do |user|
              link_to(user.full_name, admin_user_path(user))
            end
            column :company do |user|
              link_to(user.company.title, admin_company_path(user.company))
            end
            column :posts_count
            column :average_rating
          end
        end
      end
    end
  end
end
