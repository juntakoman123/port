class Api::FollowsController < ActionController::API

  def create

    follow = Follow.new(follower_id: current_user.id,inverse_follower_id: params[:id])
    if follow.save
      head :created
    else
      render json: { errors: follow.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    follow = Follow.find_by(follower_id: current_user.id,inverse_follower_id: params[:id])
    follow.delete
    head :no_content
  end
end
