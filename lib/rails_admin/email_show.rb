module RailsAdmin
  module Config
    module Actions
      class EmailShow < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :member do
          true
        end

        register_instance_option :controller do
          proc do
            redirect_to main_app.email_path(@object)
          end
        end

        register_instance_option :link_icon do
          'icon-eye-open'
        end
      end
    end
  end
end
