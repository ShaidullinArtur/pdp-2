ActiveAdmin.register Post do
  includes :author

  permit_params :title, :text, :rating

  index do
    id_column
    column :created_at
    column :title
    column :text
    column :author do |post|
      link_to(post.author.full_name, admin_user_path(post.author))
    end
    column :rating
    actions
  end

  filter :created_at
  filter :author

  show do
    panel t("formtastic.labels.details") do
      attributes_table_for(post) do
        row :id
        row :created_at
        row :title
        row :text
        row :author do |post|
          link_to(post.author.full_name, admin_user_path(post.author))
        end
        row :rating
      end
    end

    panel "Comments" do
      table_for(post.comments.includes(:author)) do
        column :id do |comment|
          link_to(comment.id, admin_comment_path(comment))
        end
        column :author do |comment|
          link_to(comment.author.full_name, admin_user_path(comment.author))
        end
        column :text
        column :created_at
      end
    end
  end

  form do |f|
    f.inputs "Post Details" do
      f.input :title
      f.input :text
      f.input :rating
    end
    f.actions
  end
end
