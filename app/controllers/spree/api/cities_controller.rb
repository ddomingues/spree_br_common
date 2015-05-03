module Spree
  module Api
    class CitiesController < Spree::Api::BaseController
      skip_before_filter :set_expiry
      skip_before_filter :check_for_user_or_api_key
      skip_before_filter :authenticate_user

      def index
        @cities = scope.ransack(params[:q]).result.
          includes(:state).order('name ASC')

        if params[:page] || params[:per_page]
          @cities = @cities.page(params[:page]).per(params[:per_page])
        end

        city = @cities.last
        if stale?(city)
          respond_with(@cities)
        end
      end

      def show
        @city = scope.find(params[:id])
        respond_with(@city)
      end

      private
      def scope
        if params[:state_id]
          @state = State.accessible_by(current_ability, :read).find(params[:state_id])
          return @state.cities.accessible_by(current_ability, :read)
        else
          return City.accessible_by(current_ability, :read)
        end
      end
    end
  end
end
