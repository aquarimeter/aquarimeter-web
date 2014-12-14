module DevisePermittedParameters
  extend ActiveSupport::Concern

  included do
    before_filter :configure_permitted_parameters
  end

end

DeviseController.send :include, DevisePermittedParameters
