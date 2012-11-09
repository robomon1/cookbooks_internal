rightscale_marker :begin

remote_file "/tmp/jenkins.key" do
  source "http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key"
  owner "root"
  group "root"
  mode "0777"
  action :create
end

bash "apt-key-add" do 
  user "root"
  cwd "/"
  code <<-EOF
apt-key add /tmp/jenkins.key
EOF
  flags "-ex"
end

bash "apt-add-source" do
  code <<-EOF
cat <<EOH> /etc/apt/sources.list.d/jenkins.list
deb http://pkg.jenkins-ci.org/debian binary/
EOH
apt-get update
EOF
  flags "-ex"
end

rightscale_marker :end
