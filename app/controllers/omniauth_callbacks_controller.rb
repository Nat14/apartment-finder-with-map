class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  # this one below will work to.
  # def twitter
  #   raise env["omniauth.auth"].inspect
  # end

  def all
      user = User.from_omniauth(request.env["omniauth.auth"])
      if user.persisted?
        sign_in_and_redirect user, notice: "Sign in!"
      else
        
      end
  end
  alias_method :twitter, :all

end
