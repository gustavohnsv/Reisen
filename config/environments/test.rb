Rails.application.configure do
  # Impede recarregamento de classes entre testes (recomendado)
  config.cache_classes = true
  config.eager_load = false

  # Exibe erros completos
  config.consider_all_requests_local = true
  config.action_controller.perform_caching = false
  config.action_dispatch.show_exceptions = false
  config.action_controller.allow_forgery_protection = false

  # ⚠️ ESSA LINHA É CRUCIAL
  # Permite qualquer host — resolve "Blocked hosts: www.example.com"
  config.hosts.clear

  # Evita problemas com Spring e threads
  config.allow_concurrency = false

  config.active_storage.service = :test
  config.action_mailer.delivery_method = :test
  config.active_support.deprecation = :stderr

  # Importante para os links de confirmação do Devise funcionarem
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
end
