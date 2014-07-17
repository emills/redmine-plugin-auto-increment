
require 'redmine'

require_dependency 'macros/auto_increment'

Redmine::Plugin.register :auto_increment do
  name 'Auto Increment Wiki Macros'
  author 'Eric Mills'
  description 'Provides wiki macros for auto incrementing values'
  url 'https://github.com/emills/redmine-plugin-auto-increment'
  author_url 'https://github.com/emills'
  version '0.0.1-SNAPSHOT'
end
