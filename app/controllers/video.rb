Clasesenvivo::App.controllers :video do
  video_upload_params = [:title, :description, :url, :tags]
  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   'Maps to url '/foo/#{params[:id]}''
  # end

  # get '/example' do
  #   'Hello world!'
  # end
  before(:new) do
    halt 403, { msg: 'envia token' }.to_json unless request.env['HTTP_AUTHORIZATION']
    @user = User.validate_token(request.env['HTTP_AUTHORIZATION'])
    halt 403, { msg: 'qien eres' }.to_json unless @user
    halt 400, { msg: 'que haces? ' }.to_json unless video_upload_params.map { |k| params.key? k.to_s }.all?
  end

  post :new, params: video_upload_params do
    params[:user] = @user
    @video = Video.new(params)
    puts @video.inspect
    @video.save ? render(:new) : @video.errors.to_json
  end

end
