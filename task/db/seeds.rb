require 'faker'
require 'activerecord-import/base'

USER_COUNT = 10_000
POSTS_PER_USER = 5
REVIEWS_PER_POST = 4



ActiveRecord::Base.transaction do
  # Create Users
  users = []
  USER_COUNT.times do
    users << User.new(username: Faker::Internet.username)
  end
  User.import users

  # Fetch all user IDs for association
  user_ids = User.pluck(:id)

  # Create Posts
  posts = []
  user_ids.each do |user_id|
    POSTS_PER_USER.times do
      posts << Post.new(
        title: Faker::Lorem.sentence,
        body: Faker::Lorem.paragraph,
        user_id: user_id
      )
    end
  end
  Post.import posts

  # Create Reviews
  post_ids = Post.pluck(:id)
  reviews = []
  post_ids.each do |post_id|
    REVIEWS_PER_POST.times do
      reviews << Review.new(
        post_id: post_id,
        user_id: user_ids.sample,
        comment: Faker::Lorem.sentence,
        rating: rand(1..5)
      )
    end
  end
  Review.import reviews
end
