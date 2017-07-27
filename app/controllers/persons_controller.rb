class PersonsController < ApplicationController
  def profile
  end

  def edit
    case request.method_symbol
    when :get
      @user = User.find_by(id: current_user[:id])
    when :post
      @user = User.find_by(id: current_user[:id])
      upload_img
      if @user.update_attributes(user_params)
          flash[:success] = t('user_form.was_update')
          redirect_to user_root_path
        else
        redirect_to :back
        end
    end
  end

  def change_theme
    theme_name = params[:theme_name]

    if current_user != nil
      @user = User.find_by(id: current_user[:id])
      @user.update_attribute(:theme, theme_name)
    else
      flash[:info] = t('settings_menu.non-user')
    end

    redirect_to root_path



  end

  private

  def user_params
    params.require(:user).permit(:firstname, :lastname, :hobbies, :about)
  end

  def upload_img_param
    params.require(:user).permit(:image)
  end

  def upload_img
    if params[:user].key?("image")
      cloudinary_params = Cloudinary::Uploader.upload(upload_img_param[:image])
      @user.update_attributes(:image => cloudinary_params["url"])
    end
  end
end
