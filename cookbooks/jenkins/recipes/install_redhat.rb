rightscale_marker :begin

remote_file "/etc/yum.repos.d/jenkins.repo" do
  source "http://pkg.jenkins-ci.org/redhat/jenkins.repo"
  owner "root"
  group "root"
  mode "0777"
  action :create
end

remote_file "/tmp/jenkins-ci.org.key" do
  source "http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key"
  owner "root"
  group "root"
  mode "0777"
  action :create
end

bash "import-key" do 
  cwd "/"
  code <<-EOF
  rpm --import /tmp/jenkins-ci.org.key
  touch /tmp/jenkins-key-imported
EOF
  flags "-ex"
  not_if "test -e /tmp/jenkins-key-imported"
end

rightscale_marker :end
