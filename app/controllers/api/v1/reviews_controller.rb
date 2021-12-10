module Api
  module V1
    class ReviewsController < ApplicationController
      def index
        reviews = Review.all
        render json: ReviewSerializer.new(reviews).serialized_json
      end

      def show
        review = Review.find_by(slug: params[:slug])
        render json: ReviewSerializer.new(review).serialized_json
      end

      def create
        review = Review.new(airline_param)

        if review.save
          render json: ReviewSerializer.new(review).serialized_json
        else
          render json: { error: review.errors.messages }, status: 422
        end
      end

      def update
        review = Review.find_by(params[:id])

        if review.update(review_param)
          render json: ReviewSerializer.new(review, options).serialized_json
        else
          render json: { error: review.errors.messages }, status: 422
        end
      end

      def destroy
        review = Review.find_by(params[:id])

        if review.destroy
          head :no_content
          render json: ReviewSerializer.new(review).serialized_json
        else
          render json: { error: review.errors.messages }, status: 422
        end
      end

      private

      def review_param
        params.require(:review).permit(:name, :description, :score, :airline_id)
      end

    end
  end
end
