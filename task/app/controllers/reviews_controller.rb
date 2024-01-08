class ReviewsController < ApplicationController
    def create
       @post = Post.find(params[:post_id])
       if @post.nil?
            render json: {status: 'error' , message: 'Post not found'}, status:  :not_found
            return   
       end

       @review = @post.reviews.create(review_params)
       if  @review.valid?
        render json: { status:'success' , message:'Review added successfully' , data: {review: @review.as_json(except: [:id , :user_id , :post_id]) }}, status: :created  
       else
        render json: {status: 'error' , message: @review.errors.objects.first.full_message}, status:  :unprocessable_entity  
      end
    end  
    
    
    def review_params
        params.permit(:user_id , :comment , :rating)
    end
end
