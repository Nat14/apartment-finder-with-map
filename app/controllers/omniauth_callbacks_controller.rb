class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  # this one below will work to.
  # def twitter
  #   raise env["omniauth.auth"].inspect
  # end

  def all
      user = User.from_omniauth(request.env["omniauth.auth"])
      if user.persisted?
        flash.notice = "Sign In!"
        sign_in_and_redirect user
      else
        session["devise.user_attributes"] = user.attributes
        redirect_to new_user_registration_path
      end
  end
  alias_method :twitter, :all

end
