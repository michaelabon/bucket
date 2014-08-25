Rails.application.routes.draw do
  post 'messages/receive' => 'messages#receive'
end
