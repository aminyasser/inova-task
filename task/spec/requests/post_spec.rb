require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "POST /posts" do
    it "creates a new post" do
      expect {
        post '/posts', params: { post: { title: 'Test Title', body: 'Test Body' , user_id: 400002 } }
      }.to change(Post, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)).to include('status' => "success", "message" =>   "Post created successfully", "post" => { "title" => "Test Title", "body" => "Test Body" , "user_id" => 400002 })
    end
  end

  describe "GET /users/:user_id/posts" do
    before do
      FactoryBot.create(:post, title: 'First Post', body: 'First Body' , user_id: 400002)
      FactoryBot.create(:post, title: 'Second Post', body: 'Second Body' , user_id: 400002)
    end

    it "returns all posts" do
      get '/user/40002/posts'
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end
end
