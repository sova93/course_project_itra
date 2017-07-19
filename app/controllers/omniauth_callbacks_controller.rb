class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def _provider_callback(provider_name)
    puts session[:omniauth_login_locale]

    I18n.locale = exctract_locale_from_url(request.env['omniauth.origin']) if request.env['omniauth.origin']


    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication

      set_flash_message(:success, :success, :kind => provider_name) if is_navigational_format?
    else
      session["devise.oauth_data"] = request.env["omniauth.auth"].except("extra")
      session["devise.oauth_data"]["extra"] = {"raw_info" => request.env["omniauth.auth"]["extra"]["raw_info"]}
      if @user.is_email_used_different_provider
        set_flash_message(:success, :email_used, :kind => @user.provider)
      end
      redirect_to new_user_registration_url
    end
  end

  def facebook
    _provider_callback "Facebook"
  end

  def vkontakte
    _provider_callback "Vkontakte"
  end

  def twitter
    _provider_callback "twitter"
  end

  def google_oauth2
    _provider_callback "google_oauth2"
  end

  # def failure
  #   puts "ploho"
  #   redirect_to root_path
  # end

  def exctract_locale_from_url(url)
    url[/^([^\/]*\/\/)?[^\/]+\/(\w{2})(\/.*)?/,2]
  end

end