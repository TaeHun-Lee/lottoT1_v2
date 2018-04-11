Rails.application.routes.draw do
    get '/' => 'home#input'
    get '/lotto' => 'home#picklotto_auto'
    get '/manual' => 'home#picklotto_manual'
    get '/manual_result' => 'home#picklotto_manual_result'
    # get '/input' => 'home#input'
    
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
