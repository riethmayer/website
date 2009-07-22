# Be sure to restart your server when you modify this file.

# DISQUS configurations
DISQUS_CONFIG = YAML.load_file("#{RAILS_ROOT}/config/disqus.yml")[RAILS_ENV]
