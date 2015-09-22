Clasesenvivo::App.controllers :auth do
  login_params = [:email, :password]

  before(:login) do
    halt 400, { msg: 'que haces? ' }.to_json unless login_params.map { |k| params.key? k.to_s }.all?
  end

  post :login, params: login_params do
    @user = User.login(params[:email], params[:password])
    @user ? render(:user) : { msg: 'quien eres?' }.to_json
  end

end
