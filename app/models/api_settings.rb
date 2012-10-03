class ApiSettings < Settingslogic
  source "#{Rails.root}/config/settings/api_settings.yml"
  namespace Rails.env
end
