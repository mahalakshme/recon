# Remove unnecessary middleware
Rails.application.config.middleware.delete ::Rack::ConditionalGet
Rails.application.config.middleware.delete ::Rack::ETag
Rails.application.config.middleware.delete ::ActionDispatch::RemoteIp
Rails.application.config.middleware.delete ::Rack::Head
Rails.application.config.middleware.delete ::Rack::Sendfile
Rails.application.config.middleware.delete ::Rack::Runtime
