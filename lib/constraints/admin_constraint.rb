class AdminConstraint
  class << self
    def matches?(request)
      !request.session[:current_user].nil?()
    end
  end
end
