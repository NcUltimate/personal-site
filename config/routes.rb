Rails.application.routes.draw do
  root 'site#bio'
  
  get '/show', to: 'site#show'
  get '/bio', to: 'site#bio'
  get '/cv', to: 'site#cv'
  get '/blog', to: 'blog#index'
  get '/github', to: 'site#github'
  get '/sandbox', to: 'site#sandbox'
end
