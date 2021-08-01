class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if login(email, password)
      flash[:success] = 'ログインに成功しました。'
      redirect_to :root
    else
      flash.now[:danger] = 'ログインに失敗しました。'
      render :new
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end
  
  private
  
  def login(email,password)
    @user = User.find_by(email: email) 
    #@userにemailが、上のdef createでとってきたemailのユーザを代入している
    
    if @user && @user.authenticate(password)
    #@userにはUser.find_by(email: email) のユーザが存在しているか確認している（いなければfalse,いたらtrue)
    #@user.authenticate(password)はパスワードが一致していればtrueを返す
    #つまりUser.find_by(email: email) が存在し、かつそのパスワードがあっていれば、、という意味
     session[:user_id] = @user.id
     return true
    else
      #ログイン失敗
    return false
    end
  end
end