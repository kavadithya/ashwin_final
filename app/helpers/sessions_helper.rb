module SessionsHelper
	def sign_in(user)
		cookies.permanent[:remember_token] = user.remember_token
		self.current_user = user 
	end
	def signed_in?
    	!current_user.nil?
  	end
	def current_user=(user)
    	@current_user = user
  end
  def current_user
   	@current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end
  def sign_out(user)
  	cookies.delete :remember_token
  	self.current_user = nil
 	end
  def current_user?(user)
    user == current_user
  end
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end
  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end
  def owner
    User.find(current_user.domain.ownerid)
  end
  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user) or current_user.admin?
    end
    def destroy
      User.find(params[:id]).destroy
      flash[:success] = "User destroyed."
      redirect_to users_url
    end
    def admin_user
      redirect_to(root_path) unless signed_in? and current_user.admin?
    end
    def admin_user?
      if signed_in?
        current_user.admin?
      else
        false
      end

    end
      
end
