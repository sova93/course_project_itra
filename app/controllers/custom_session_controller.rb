class CustomSessionController < Devise::SessionsController

  def destroy
    super
    flash.delete :notice
    set_flash_message! :success, :signed_out
  end
end