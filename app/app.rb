module Clasesenvivo
  class App < Padrino::Application
    register Padrino::Mailer
    register Padrino::Helpers

    enable :sessions
    before { content_type :json }
  end
end
