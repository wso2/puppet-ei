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

# Class: ei_analytics
# Init class of EI Integrator - Analytics profile
class ei_analytics (
  $user = $ei_analytics::params::user,
  $user_id = $ei_analytics::params::user_id,
  $user_group = $ei_analytics::params::user_group,
  $user_group_id = $ei_analytics::params::user_group_id,
  $product = $ei_analytics::params::product,
  $product_version = $ei_analytics::params::product_version,
  $profile = $ei_analytics::params::profile,
  $service_name = $ei_analytics::params::service_name,
  $template_list = $ei_analytics::params::template_list,
  $jre_version = $ei_analytics::params::jre_version,
  $start_script_template = $ei_analytics::params::start_script_template,

  # ------ Configuration Params ------ #

  # analytics-datasources.xml
  $event_store_db_url = $ei_analytics::params::event_store_db_url,
  $event_store_db_username = $ei_analytics::params::event_store_db_username,
  $event_store_db_password = $ei_analytics::params::event_store_db_password,
  $event_store_db_driver = $ei_analytics::params::event_store_db_driver,

  $processed_data_store_db_url = $ei_analytics::params::processed_data_store_db_url,
  $processed_data_store_db_username = $ei_analytics::params::processed_data_store_db_username,
  $processed_data_store_db_password = $ei_analytics::params::processed_data_store_db_password,
  $processed_data_store_db_driver = $ei_analytics::params::processed_data_store_db_driver,

  # carbon.xml
  $security_keystore_location = $ei_analytics::params::security_keystore_location,
  $security_keystore_type = $ei_analytics::params::security_keystore_type,
  $security_keystore_password = $ei_analytics::params::security_keystore_password,
  $security_keystore_key_alias = $ei_analytics::params::security_keystore_key_alias,
  $security_keystore_key_password = $ei_analytics::params::security_keystore_key_password,

  $security_trust_store_location = $ei_analytics::params::security_trust_store_location,
  $security_trust_store_type = $ei_analytics::params::security_trust_store_type,
  $security_trust_store_password = $ei_analytics::params::security_trust_store_password,

  # axis2.xml
  $clustering_enabled = $ei_analytics::params::clustering_enabled,
  $clustering_membership_scheme = $ei_analytics::params::clustering_membership_scheme,
  $clustering_wka_members = $ei_analytics::params::clustering_wka_members,

  # user-mgt.xml
  $admin_username = $ei_analytics::params::admin_username,
  $admin_password = $ei_analytics::params::admin_password,
)

  inherits ei_analytics::params {

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

  # Install WSO2 Enterprise Integrator
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
    Note: Ensure that file is available in modules -> ei_analytics -> files
  */
  # file { "${install_path}/repository/some_file":
  #   owner  => $user,
  #   group  => $user_group,
  #   mode   => '0644',
  #   source => "puppet:///modules/${module_name}/some_file",
  # }
}
