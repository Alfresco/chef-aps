name 'aps'
maintainer 'Alfresco T&A Team'
maintainer_email 'devops@alfresco.com'
license 'Apache 2.0'
description 'Installs/Configures chef-aps'
long_description 'Installs/Configures chef-aps'
version '0.1.0'

chef_version '~> 12'
issues_url  'https://github.com/Alfresco/chef-aps/issues'
source_url  'https://github.com/Alfresco/chef-aps'

supports 'centos', '>= 7.0'

depends 'aps-proxy'
depends 'aps-db'
depends 'aps-core'
depends 'aps-appserver'
depends 'apache_tomcat'
depends 'poise-derived', '~> 1.0.0'
depends 'alfresco-utils', '~> 1.1.0'
