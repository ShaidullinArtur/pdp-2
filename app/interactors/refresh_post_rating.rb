class RefreshPostRating
  include Interactor

  delegate :post, to: :context

  def call
    recalculate_post_rating
    recalculate_post_author_rating
  end

  private

  def recalculate_post_rating
    post.update(rating: post.ratings.average(:value).round(1).to_f)
  end

  def recalculate_post_author_rating
    post.author.update(average_rating: post.author.posts.average(:rating).round(1).to_f)
  end
end
