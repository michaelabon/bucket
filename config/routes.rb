Rails.application.routes.draw do
  post 'messages', to: 'messages#receive'
end
