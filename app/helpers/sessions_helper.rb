module SessionsHelper
    def current_user
        @current_user ||=User.find_by(id: session[:user_id])
        #session[:user_id]はdefcreateのとこで作ってる
    end
    
    def logged_in?
        !!current_user
    end
end
