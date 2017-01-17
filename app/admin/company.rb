ActiveAdmin.register Company do
  includes :owner

  permit_params :title, :subdomain, owner_attributes: %i(id full_name email password password_confirmation)

  index do
    id_column
    column :created_at
    column :title
    column :subdomain do |company|
      link_to(company.subdomain, root_url(subdomain: company.subdomain), target: "_blank")
    end
    column :owner do |company|
      link_to(company.owner.full_name, admin_user_path(company.owner))
    end
    actions
  end

  filter :created_at

  show do
    panel t("formtastic.labels.details") do
      attributes_table_for(company) do
        row :id
        row :created_at
        row :title
        row :subdomain do |company|
          link_to(company.subdomain, root_url(subdomain: company.subdomain), target: "_blank")
        end
        row :owner do |company|
          link_to(company.owner.full_name, admin_user_path(company.owner)) if company.owner.present?
        end
      end
    end

    panel "Users" do
      table_for(company.users) do
        column :user do |user|
          link_to(user.full_name, admin_user_path(user))
        end
        column :posts_count
        column :average_rating
      end
    end

    panel "Posts" do
      table_for(company.posts.includes(:author)) do
        column :title do |post|
          link_to(post.title, admin_post_path(post))
        end
        column :author do |post|
          link_to(post.author.full_name, admin_user_path(post.author))
        end
        column :text
        column :rating
      end
    end
  end

  form do |f|
    f.inputs "Company Details" do
      f.input :title
      f.input :subdomain unless f.object.persisted?
      f.inputs "Owner", for: [:owner, f.object.owner || User.new] do |owner_form|
        owner_form.input :full_name
        owner_form.input :email
        owner_form.input :password
        owner_form.input :password_confirmation
      end
    end
    f.actions
  end

  controller do
    def create
      @company = Company.new(permitted_params[:company])
      @company.owner.subdomain = @company.subdomain
      create!
    end

    def update
      if params[:company][:owner_attributes][:password].blank?
        params[:company][:owner_attributes].delete("password")
        params[:company][:owner_attributes].delete("password_confirmation")
      end
      super
    end
  end
end
