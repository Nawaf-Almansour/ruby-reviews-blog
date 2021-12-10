module Api
  module V1
    class AirlinesController < ApplicationController
      protect_from_forgery with: :null_session
      # GET /api/v1/airlines
      def index
        airlines = Airline.all

        render json: AirlineSerializer.new(airlines, options).serialized_json
      end

      def show
        airline = Airline.find_by(slug: params[:slug])

        render json: AirlineSerializer.new(airline, options).serialized_json
      end

      # POST /api/v1/airlines
      def create
        airline = Airline.new(airline_param)

        if airline.save
          render json: AirlineSerializer.new(airline).serialized_json
        else
          render json: { error: airline.errors.messages }, status: 422
        end
      end


      # PATCH /api/v1/airlines/:slug
      def update
        airline = Airline.find_by(slug: params[:slug])

        if airline.update(airline_param)
          render json: AirlineSerializer.new(airline, options).serialized_json
        else
          render json: { error: airline.errors.messages }, status: 422
        end
      end

      # DELETE /api/v1/airlines/:slug
      def destroy
        airline = Airline.find_by(slug: params[:slug])

        if airline.destroy
          head :no_content
        else
          render json: { error: airline.errors.messages }, status: 422
        end
      end

      private

      def airline_param
        params.require(:airline).permit(:name, :image_url)

      end

      def options
        @options ||= { include: %i[reviews]}
      end
    end
  end
end
