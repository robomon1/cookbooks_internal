maintainer       "RightScale, Inc."
maintainer_email "ps@rightscale.com"
license          "Copyright RightScale, Inc. All rights reserved."
description      "Installs/Configures NuoDB with inputs for nuodb default.properties file"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "1.3"

depends "rightscale"

recipe "nuodb::default", "Default NuoDB recipe, this loads nuodb specific chef stuff"
recipe "nuodb::install_nuodb", "Installs NuoDB"
recipe "nuodb::start_trans", "Starts NuoDB trans engine"
recipe "nuodb::start_stor", "Starts NuoDB stor engine"
recipe "nuodb::start_nuodb_broker", "Starts NuoDB broker"
recipe "nuodb::set_peer", "Sets node as nuodb peer"

attribute "nuodb/nuodb_type",
      :description => "The Nuodb entity type, nuodb_broker,nuodb_trans,nuodb_storage",
      :recipes => [ "nuodb::default","nuodb::start_nuodb_broker","nuodb::set_peer","nuodb::start_trans","nuodb::start_stor","nuodb::install" ],
      :choice => [ "nuodbbroker","broker+peer","stor","trans"],
      :display_name => "Type of Nuodb DB entity this machine will be tagged as and process run as",
      :default => "nuodbbroker",
      :required => "recommended"

attribute "nuodb/nuodb_download_url",
      :description => "The nuodb download url",
      :recipes => [ "nuodb::default","nuodb::start_nuodb_broker","nuodb::set_peer","nuodb::start_trans","nuodb::start_stor","nuodb::install" ],
      :display_name => "Nuodb download URL",
      :default => "http://www.nuodb.com/latest/nuodb-1.0-GA.linux.x86_64.rpm",
      :required => "recommended"

attribute "nuodb/nuodb_broker_flag",
      :description => "The nuodb config broker flag",
      :recipes => [ "nuodb::default","nuodb::start_nuodb_broker","nuodb::set_peer","nuodb::start_trans","nuodb::start_stor","nuodb::install" ],
      :display_name => "Nuodb broker flag ",
      :default => "true",
      :choice => ["true","false"],
      :required => "recommended"


attribute "nuodb/nuodb_domain",
      :description => "The name used to identify the domain that this agent is a part of",
      :recipes => [ "nuodb::default","nuodb::start_nuodb_broker","nuodb::set_peer","nuodb::start_trans","nuodb::start_stor","nuodb::install" ],
      :default => "domain",
      :display_name => "Nuodb Domain",
      :type  => "string",
      :required => "recommended"

attribute "nuodb/nuodb_domain_password",
      :description => "The default administrative password, and the secret used by agents to
 setup and maintain the domain securely",
      :recipes => [ "nuodb::default","nuodb::start_nuodb_broker","nuodb::set_peer","nuodb::start_trans","nuodb::start_stor","nuodb::install" ],
      :default => "bird",
      :display_name => "domain_password",
      :required => "recommended"

attribute "nuodb/nuodb_port",
      :description => "The port that this nuodb agent listens on for all incoming connections",
      :recipes => [ "nuodb::default","nuodb::start_nuodb_broker","nuodb::set_peer","nuodb::start_trans","nuodb::start_stor","nuodb::install" ],
      :default => "48004",
      :display_name => "Nuodb port",
      :required => "recommended"

attribute "nuodb/nuodb_advertise_alt",
      :description => "A flag specifying whether the alternate address should be advertised instead of the locally observed network addresses. This is only meaningful for brokers, because only brokers advertise addresses to clients and admins. If nuodb_peer is set to true then this will be overridden to true",
      :recipes => [ "nuodb::default","nuodb::start_nuodb_broker","nuodb::set_peer","nuodb::start_trans","nuodb::start_stor","nuodb::install" ],
      :default => "true",
      :display_name => "Nuodb advertise altaddr",
      :choice => [ "true","false"],
      :required => "recommended"

attribute "nuodb/nuodb_bindir",
      :description => "Commented out in template! The location of the directory with the 'nuodb' executable, which is typically the same as the directory where the nuoagent.jar file is found",
      :recipes => [ "nuodb::default","nuodb::start_nuodb_broker","nuodb::set_peer","nuodb::start_trans","nuodb::start_stor","nuodb::install" ],
      :default => ".",
      :display_name => "Nuodb bindir",
      :required => "recommended"

attribute "nuodb/nuodb_portrange",
      :description => "A range of port numbers that nuodb instances should be confined to.",
      :recipes => [ "nuodb::default","nuodb::start_nuodb_broker","nuodb::set_peer","nuodb::start_trans","nuodb::start_stor","nuodb::install" ],
      :default => "48005-48100",
      :display_name => "Nuodb port range",
      :required => "recommended"

attribute "nuodb/nuodb_broadcast",
      :description => "Commented out in Template! The interval (in seconds) that brokers should wait between sending out UDP broadcast messages for local discovery, and that agents should wait to hear those messages on startup. By default broadcast is turned off so peering is done using the 'peer' property.",
      :recipes => [ "nuodb::default","nuodb::start_nuodb_broker","nuodb::set_peer","nuodb::start_trans","nuodb::start_stor","nuodb::install" ],
      :default => "10",
      :display_name => "Nuodb broadcast",
      :required => "recommended"

attribute "nuodb/nuodb_require_connect_key",
      :description => " A flag specifying whether nuodb instances can only be started through this agent (as opposed to directly starting a nuodb process on the system). If this flag is true then a connection key is required of all nuodb instances. A connection key is only available if the process was started through a request on the agent. This is a good best-practice flag for locking down a system.",
      :recipes => [ "nuodb::default","nuodb::start_nuodb_broker","nuodb::set_peer","nuodb::start_trans","nuodb::start_stor","nuodb::install" ],
      :default => "false",
      :choice => [ "true","false"],
      :display_name => "Nuodb require connect key",
      :required => "recommended"

attribute "nuodb/nuodb_database",
      :description => "Datbase input for running the various Nuodb operational scripts, such as starting a storage manager etc",
      :recipes => [ "nuodb::default","nuodb::start_nuodb_broker","nuodb::set_peer","nuodb::start_trans","nuodb::start_stor","nuodb::install" ],
      :default => "test",
      :display_name => "Nuodb Database",
      :required => "recommended"

attribute "nuodb/nuodb_dba_user",
      :description => "DBA user input for running the various Nuodb operational scripts, such as starting a storage manager etc. It would be good to use a credential for this",
      :recipes => [ "nuodb::default","nuodb::start_nuodb_broker","nuodb::set_peer","nuodb::start_trans","nuodb::start_stor","nuodb::install" ],
      :default => "dba",
      :display_name => "Nuodb Database User",
      :required => "recommended"

attribute "nuodb/nuodb_dba_password",
      :description => "Datbase password input for running the various Nuodb operational scripts, such as starting a storage manager etc. It would be good to use a credential for this",
      :recipes => [ "nuodb::default","nuodb::start_nuodb_broker","nuodb::set_peer","nuodb::start_trans","nuodb::start_stor","nuodb::install" ],
      :default => "goalie",
      :display_name => "Nuodb Database User Password",
      :required => "recommended"

attribute "nuodb/nuodb_archive_location",
      :description => "Nuodb database archive location - in the future this will include HDFS, or S3 support",
      :recipes => [ "nuodb::default","nuodb::start_nuodb_broker","nuodb::set_peer","nuodb::start_trans","nuodb::start_stor","nuodb::install" ],
      :default => "/tmp/archive",
      :display_name => "Nuodb Database archive location",
      :required => "recommended"

attribute "nuodb/nuodb_arch_int_flag",
      :description => "Nuodb archive init flag - set to true to initialize archive",
      :recipes => [ "nuodb::default","nuodb::start_nuodb_broker","nuodb::set_peer","nuodb::start_trans","nuodb::start_stor","nuodb::install" ],
      :default => "true",
      :choice => [ "true","false"],
      :display_name => "Nuodb Database User Password",
      :required => "recommended"

