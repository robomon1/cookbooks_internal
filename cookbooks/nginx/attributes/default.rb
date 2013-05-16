default[:nginx][:configuration][:keepaliveTimeout]="65"'
default[:nginx][:configuration][:serverName]="_"'
default[:nginx][:configuration][:port]="80"
default[:nginx][:configuration][:worker_connections]="1024"

#fastcgiparams
default[:nginx][:fastcgi_params]=Hash.new
default[:nginx][:fastcgi_params]["QUERY_STRING"]='$query_string'
default[:nginx][:fastcgi_params]["REQUEST_METHOD"]='$request_method'
default[:nginx][:fastcgi_params]["CONTENT_TYPE"]='$content_type'
default[:nginx][:fastcgi_params]["CONTENT_LENGTH"]='$content_length'
default[:nginx][:fastcgi_params]["SCRIPT_NAME"]='$fastcgi_script_name'
default[:nginx][:fastcgi_params]["REQUEST_URI"]='$request_uri'
default[:nginx][:fastcgi_params]["DOCUMENT_URI"]='$document_uri'
default[:nginx][:fastcgi_params]["DOCUMENT_ROOT"]='$document_root'
default[:nginx][:fastcgi_params]["SERVER_PROTOCOL"]='$server_protocol'
default[:nginx][:fastcgi_params]["GATEWAY_INTERFACE"]='CGI/1.1'
default[:nginx][:fastcgi_params]["SERVER_SOFTWARE"]='nginx/$nginx_version'
default[:nginx][:fastcgi_params]["REMOTE_ADDR"]='$remote_addr'
default[:nginx][:fastcgi_params]["REMOTE_PORT"]='$remote_port'
default[:nginx][:fastcgi_params]["SERVER_ADDR"]='$server_addr'
default[:nginx][:fastcgi_params]["SERVER_PORT"]='$server_port'
default[:nginx][:fastcgi_params]["SERVER_NAME"]='$server_name'
default[:nginx][:fastcgi_params]["REDIRECT_STATUS"]='200'