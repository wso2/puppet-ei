# ----------------------------------------------------------------------------
#  Copyright (c) 2018 WSO2, Inc. http://www.wso2.org
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
# ----------------------------------------------------------------------------

# Class: ei_msf4j
# Init class of EI Integrator default profile
class ei_msf4j (
  $user = $ei_msf4j::params::user,
  $user_id = $ei_msf4j::params::user_id,
  $user_group = $ei_msf4j::params::user_group,
  $user_group_id = $ei_msf4j::params::user_group_id,
  $product = $ei_msf4j::params::product,
  $product_version = $ei_msf4j::params::product_version,
  $profile = $ei_msf4j::params::profile,
  $service_name = $ei_msf4j::params::service_name,
  $template_list = $ei_msf4j::params::template_list,
  $jre_version = $ei_msf4j::params::jre_version,
  $start_script_template = $ei_msf4j::params::start_script_template,

  # ------ Configuration Params ------ #

  # netty-transports.yaml
  $host = $ei_msf4j::params::host,

  # data-agent-config.xml
  $thrift_agent_trust_store = $ei_msf4j::params::thrift_agent_trust_store,
  $thrift_agent_trust_store_password = $ei_msf4j::params::thrift_agent_trust_store_password,

  $binary_agent_trust_store = $ei_msf4j::params::binary_agent_trust_store,
  $binary_agent_trust_store_password = $ei_msf4j::params::binary_agent_trust_store_password,
)

  inherits ei_msf4j::params {

  if $::osfamily == 'redhat' {
    $ei_package = 'wso2ei-linux-installer-x64-6.3.0.rpm'
    $installer_provider = 'rpm'
    $install_path = "/usr/lib64/wso2/${product}/${product_version}"
  }
  elsif $::osfamily == 'debian' {
    $ei_package = 'wso2ei-linux-installer-x64-6.3.0.deb'
    $installer_provider = 'dpkg'
    $install_path = "/usr/lib/wso2/${product}/${product_version}"
  }

  # Create wso2 group
  group { $user_group:
    ensure => present,
    gid    => $user_group_id,
    system => true,
  }

  # Create wso2 user
  user { $user:
    ensure => present,
    uid    => $user_id,
    gid    => $user_group_id,
    home   => "/home/${user}",
    system => true,
  }

  # Ensure the installation directory is available
  file { "/opt/${product}":
    ensure => 'directory',
    owner  => $user,
    group  => $user_group,
  }

  # Copy the installer to the directory
  file { "/opt/${product}/${ei_package}":
    owner  => $user,
    group  => $user_group,
    mode   => '0644',
    source => "puppet:///modules/${module_name}/${ei_package}",
  }

  # Install WSO2 API Manager
  package { $product:
    ensure   => installed,
    provider => $installer_provider,
    source   => "/opt/${product}/${ei_package}"
  }

  # Change the ownership of the installation directory to wso2 user & group
  file { $install_path:
    ensure  => directory,
    owner   => $user,
    group   => $user_group,
    require => [ User[$user], Group[$user_group]],
    recurse => true
  }

  # Copy configuration changes to the installed directory
  $template_list.each | String $template | {
    file { "${install_path}/${template}":
      ensure  => file,
      owner   => $user,
      group   => $user_group,
      mode    => '0644',
      content => template("${module_name}/carbon-home/${template}.erb")
    }
  }

  # Copy wso2server.sh to installed directory
  file { "${install_path}/${start_script_template}":
    ensure  => file,
    owner   => $user,
    group   => $user_group,
    mode    => '0754',
    content => template("${module_name}/carbon-home/${start_script_template}.erb")
  }

  # Copy the unit file required to deploy the server as a service
  file { "/etc/systemd/system/${service_name}.service":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0754',
    content => template("${module_name}/${service_name}.service.erb"),
  }

  /*
    Following script can be used to copy file to a given location.
    This will copy some_file to install_path -> repository.
    Note: Ensure that file is available in modules -> apim -> files
  */
  # file { "${install_path}/repository/some_file":
  #   owner  => $user,
  #   group  => $user_group,
  #   mode   => '0644',
  #   source => "puppet:///modules/${module_name}/some_file",
  # }
}
