require "active_support/core_ext/integer/time"
Rails.application.configure do
  config.enable_reloading = false
  config.eager_load = true
  config.consider_all_requests_local = true
  config.public_file_server.enabled = true
  config.assets.compile = true
  config.log_level = :debug
  config.active_support.report_deprecations = false
end
