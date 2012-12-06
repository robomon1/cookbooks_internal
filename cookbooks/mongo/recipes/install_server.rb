rightscale_marker :begin

package "numactl" do
  action :install
end

remote_file "/tmp/mongodb.tar.gz" do
  source node[:mongo][:source]
  owner "root"
  group "root"
  mode "0644"
  action :create
end

user node[:mongo][:user] do
  action :create
end

directory node[:mongo][:install_dir] do
  owner node[:mongo][:user]
  group node[:mongo][:user]
  mode 0755
  recursive true
  action :create
end

bash "extract-mongo" do
  cwd "/"
  code <<-EOF
  tar -xzf /tmp/mongodb.tar.gz -C #{node[:mongo][:install_dir]} --strip-components=1
EOF
end

directory node[:mongo][:data_dir] do
  owner node[:mongo][:user]
  group node[:mongo][:user]
  mode 0755
  recursive true
  action :create
end

directory node[:mongo][:log_dir] do
  owner node[:mongo][:user]
  group node[:mongo][:user]
  mode 0755
  recursive true
  action :create
end

%w{mongo mongod mongodump mongoexport mongofiles mongoimport mongorestore mongos mongotop mongosniff mongostat}.each do |binary|
  link "/usr/bin/#{binary}" do
    to "#{node[:mongo][:install_dir]}/bin/#{binary}"
    link_type :symbolic
    action :create
  end
end

template "#{node[:mongo][:conf_file]}" do
  source "mongo.conf.erb"
  owner node[:mongo][:user]
  group node[:mongo][:user]
  mode 0777
  variables( :db_path => node[:mongo][:data_dir],
              :pid_file => "#{node[:mongo][:pid_dir]}/#{node[:mongo][:service]}.pid",
              :port => node[:mongo][:port],
              :web_admin_port => node[:mongo][:web_admin_port],
              :replSet => node[:mongo][:replSet] )
  action :create
end

template "/etc/init.d/#{node[:mongo][:service]}" do
  source "mongodb-init.erb"
  owner "root"
  group "root"
  mode "0777"
  variables( :db_path => node[:mongo][:data_dir] )
  action :create
end

directory node[:mongo][:pid_dir] do
  owner node[:mongo][:user]
  group node[:mongo][:user]
  mode 0777
  action :create
end

service node[:mongo][:service] do
  action [ :enable ]
end

bash "start-service" do
  code <<-EOF
service #{node[:mongo][:service]} start
EOF
  flags "-ex"
end
#service node[:mongo][:service] do
#  action :start
#end

sys_firewall node[:mongo][:port] do
  action :update
end

sys_firewall node[:mongo][:web_admin_port] do
  action :update
end

if !node[:mongo][:replSet].nil?
  log node[:mongo][:replSet]
  right_link_tag "mongo:replSet=#{node[:mongo][:replSet]}" do
    action :publish 
  end
  right_link_tag "mongo:port=#{node[:mongo][:port]}" do
    action :publish 
  end
end

rightscale_marker :end