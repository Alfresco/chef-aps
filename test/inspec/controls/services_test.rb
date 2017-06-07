# services = %w(haproxy mysql elasticsearch tomcat-activiti)

components = node.content['aps']['components']
proxy_engine = node.content['aps-proxy']['engine']
db_engine = node.content['aps-db']['engine']
appserver_engine = node.content['appserver']['engine']

services = []
services.push('haproxy') if components.include?('proxy') && proxy_engine.to_s == 'haproxy'
services.push('tomcat-activiti') if components.include?('appserver') && appserver_engine.to_s == 'tomcat'
services.push('mysql-local') if components.include?('db') && db_engine.to_s == 'mysql'
services.push('postgresql') if components.include?('db') && db_engine.to_s == 'postgres'

services.each do |service|
  describe service(service.to_s) do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
end
