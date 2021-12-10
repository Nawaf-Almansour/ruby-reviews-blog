module Api
  module V1
    class ReviewsController < ApplicationController
      protect_from_forgery with: :null_session

      # POST /api/v1/reviews
      def create
        review = Review.new(review_params)

        if review.save
          render json: ReviewSerializer.new(review).serialized_json
        else
          render json: { error: review.errors.messages }, status: 422
        end
      end

      def update
        review = Review.find(params[:id])

        if review.update(review_params)
          render json: ReviewSerializer.new(review, options).serialized_json
        else
          render json: { error: review.errors.messages }, status: 422
        end
      end

      # DELETE /api/v1/reviews/:id
      def destroy
        review = Review.find(params[:id])

        if review.destroy
          head :no_content
        else
          render json: { error: review.errors.messages }, status: 422
        end
      end

      private

      # Strong params
      def review_params
        params.require(:review).permit(:title, :description, :score, :airline_id)
      end


    end
  end
end
