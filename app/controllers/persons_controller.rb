class PersonsController < ApplicationController

  def index
    @users = User.all
    authorize! :index, User
  end

  def profile
    authorize! :show_profile, User
    @user_obj = User.find(current_user[:id])
    @user_instructions = Instruction.where(user_id: @user_obj)
  end

  def show
    authorize! :show, Instruction
    @user_obj = User.find(params[:id])
    @user_instructions = Instruction.where(user_id: @user_obj)
  end

  def edit
    authorize! :update, User
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

  def block
    authorize! :block, User
    @user = User.find(params[:id])
    unless @user.banned?
      @user.banned=true
      redirect_to  request.referer if @user.save
    end
  end

  def unblock
    authorize! :block, User
    @user = User.find(params[:id])
    if @user.banned?
      @user.banned=false
      redirect_to  request.referer if @user.save
    end
  end

  def destroy
    authorize! :destroy, User
    @user = User.find(params[:id])
    redirect_to  request.referer if @user.destroy
  end

  def sort_up_down
    @user_obj = User.find(params[:id])
    @user_instructions = Instruction.where(user_id: @user_obj.id).order(:name=>'asc')
  end

  def sort_down_up
    @user_obj = User.find(params[:id])
    @user_instructions = Instruction.where(user_id: @user_obj.id).order(:name=>'desc')
  end

  def change_theme
    begin
      authorize! :change_theme, User
      @user = User.find_by(id: current_user[:id])
      @user.update_attribute(:theme, params[:theme_name])
    rescue AccessGranted::AccessDenied
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
