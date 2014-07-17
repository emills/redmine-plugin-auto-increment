
require 'redmine'

require_dependency 'wiki_auto_increment_macros'

Redmine::Plugin.register :wiki_auto_increment do
  name 'Auto Increment Wiki Macros'
  author 'Eric Mills'
  description 'Provides wiki macros for auto incrementing alpha or numeric values'
  url 'https://github.com/emills/redmine-plugin-auto-increment'
  author_url 'https://github.com/emills'
  version '14.07.00-SNAPSHOT'
end
