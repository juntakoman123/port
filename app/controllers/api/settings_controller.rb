class Api::SettingsController < ActionController::API
  def index
    my_name = current_user.name
    render json: my_name
  end

  def update
    if params[:name].blank?
      render json: "空白です" , status: :unprocessable_entity
      return
    end

    u = User.find_by(id: current_user.id)
    if params[:image]
       u.image_name = "#{u.id}.png"
       path = 'app/assets/images/' + u.image_name
      image = params[:image]
      File.binwrite(path,image.read)
    end
    u.name = params[:name]
    u.save :validate => false
    head :no_content
  end
end
