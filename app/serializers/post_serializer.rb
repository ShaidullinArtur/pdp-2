class PostSerializer < ApplicationSerializer
  attributes :id, :created_at, :title, :text, :rating

  belongs_to :author
end
