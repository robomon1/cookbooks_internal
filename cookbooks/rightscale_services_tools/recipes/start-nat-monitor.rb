#
# Cookbook Name:: rightscale_services_tools
# Recipe:: start-nat-monitor
#
# Copyright 2013, Rightscale Inc.
#
# All rights reserved - Do Not Redistribute
#

rightscale_marker :begin

bash "start nat_monitor.sh" do
  user "root"
  cwd "/root"
  code <<-EOH
  echo `whoami`
  for v in `env`; do
    echo $v
  done
  
  pkill nat-monitor > /dev/null
  /root/nat-monitor.sh >> /var/log/nat-monitor.log &
  EOH
end

rightscale_marker :end