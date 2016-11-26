##
# 在生产环境中access_token应单独使用一个库
Rails.configuration.x.app_access_token.storage = Rails.cache