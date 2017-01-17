ActiveAdmin.register User do
  includes :company

  permit_params :email, :full_name, :subdomain, :password, :password_confirmation

  index do
    id_column
    column :created_at
    column :email
    column :full_name
    column :company do |user|
      link_to(user.company.title, admin_company_path(user.company)) if user.company.present?
    end
    column :posts_count
    column :average_rating
    actions
  end

  filter :email
  filter :company
  filter :created_at
  filter :posts_count
  filter :average_rating

  show do
    panel t("formtastic.labels.details") do
      attributes_table_for(user) do
        row :id
        row :created_at
        row :email
        row :full_name
        row :company do |user|
          link_to(user.company.title, admin_company_path(user.company)) if user.company.present?
        end
        row :posts_count
        row :average_rating
      end
    end

    panel "Posts" do
      table_for(user.posts) do
        column :title do |post|
          link_to(post.title, admin_post_path(post))
        end
        column :text
        column :rating
      end
    end
  end

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :full_name
      f.input :subdomain,
        label: "Company", as: :select,
        collection: Company.all.map { |c| [c.title, c.subdomain] },
        include_blank: false
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  controller do
    def update
      if params[:user][:password].blank?
        params[:user].delete("password")
        params[:user].delete("password_confirmation")
      end
      super
    end
  end
end
