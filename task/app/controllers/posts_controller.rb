class PostsController < ApplicationController
    def user_posts 
        @posts = Post.where(user_id: params[:user_id]).page(params[:page])
        render json: {posts: @posts.as_json(except: [:id]) }
    end   

    def create
        @post = Post.create(post_params)
        if @post.valid?
          render json: { status:'success' , message:'Post created successfully' , data: {post: @post }}, status: :created  
        else
          render json: {status: 'error' , message: @post.errors.objects.first.full_message}, status:  :unprocessable_entity  
        end
    end 
    
    
    def top_posts
        @posts = Post.joins(:reviews).group(:id).order('avg(reviews.rating) desc').page(params[:page])
        render json: {top_posts: @posts.as_json(except: [:id]) }
    end
    
    def post_params
        params.permit(:title , :body , :user_id)
    end
end
