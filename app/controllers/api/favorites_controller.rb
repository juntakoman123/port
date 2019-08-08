class Api::FavoritesController < ActionController::API
  def create
      favorite = Favorite.new(user_id: current_user.id, tweet_id: params[:id])
      if favorite.save
        head :created
      else
        render json: { errors: favorite.errors.full_messages }, status: :unprocessable_entity
      end
  end

    def destroy
      favorite = Favorite.find_by(user_id: current_user.id, tweet_id: params[:id])
      favorite.destroy
      head :no_content
    end

end
