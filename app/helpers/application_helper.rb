module ApplicationHelper
  def available_themes
    out = []
    Rails.application.config.assets.precompile.each do |item|
      if item.is_a? String
        if item.starts_with?("themes") && item.ends_with?("bootstrap.css")
          out << item.split('/')[-1].split('_')[0]
        end
      end
    end
    return out
  end

  def current_user_theme
    if current_user && current_user[:theme] != nil
      return current_user[:theme] if current_user
    end
    return 'united'
  end
end