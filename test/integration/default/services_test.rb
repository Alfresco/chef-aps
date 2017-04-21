services = %w(haproxy mysql elasticsearch)

services.each do |service|
  describe service(service.to_s) do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
end
