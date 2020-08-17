Rails.application.routes.draw do
  scope "(:locale)", locale: /vi|en/ do
    root "static_pages#home"

    get "/home", to: "static_pages#home"
  end
end
