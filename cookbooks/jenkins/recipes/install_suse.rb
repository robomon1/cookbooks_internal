rightscale_marker :begin

bash "zypper-add-jenkins-repo" do
  cwd "/"
  code <<-EOF
zypper addrepo http://pkg.jenkins-ci.org/opensuse/ jenkins
EOF
  flags "-ex"
end

rightscale_marker :end
