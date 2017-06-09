# services = %w(haproxy mysql elasticsearch tomcat-activiti)

components = node.content['aps']['components']
proxy_engine = node.content['aps-proxy']['engine']

services = []
services.push('haproxy') if components.include?('proxy') && proxy_engine.to_s == 'haproxy'

services.each do |service|
  describe service(service.to_s) do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
end
