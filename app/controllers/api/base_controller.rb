module Api
  class BaseController < ApplicationController
    include ActionView::Helpers::NumberHelper
    
    abstract!
  end
end
