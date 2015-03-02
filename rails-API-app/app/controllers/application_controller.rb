class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For applications, you may want to use :exception instead.
  protect_from_forgery with: :null_session
end
