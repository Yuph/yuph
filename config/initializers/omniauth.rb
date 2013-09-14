Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, "165044993686486", "9679628655333f4fded60e252d09ae9e", :scope => "email"
  end
