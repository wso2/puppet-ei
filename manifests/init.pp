# ------------------------------------------------------------------------------
# Copyright (c) 2017, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ------------------------------------------------------------------------------

# Manages WSO2 Application Server deployment
class wso2ei (
  # wso2ei specific configuration data
  $ei_wsdl_epr_prefix          = $wso2ei::params::ei_wsdl_epr_prefix,

  $packages               = $wso2ei::params::packages,
  $template_list          = $wso2ei::params::template_list,
  $file_list              = $wso2ei::params::file_list,
  $patch_list             = $wso2ei::params::patch_list,
  $cert_list              = $wso2ei::params::cert_list,
  $system_file_list       = $wso2ei::params::system_file_list,
  $directory_list         = $wso2ei::params::directory_list,
  $hosts_mapping          = $wso2ei::params::hosts_mapping,
  $java_home              = $wso2ei::params::java_home,
  $java_prefs_system_root = $wso2ei::params::java_prefs_system_root,
  $java_prefs_user_root   = $wso2ei::params::java_prefs_user_root,
  $vm_type                = $wso2ei::params::vm_type,
  $wso2_user              = $wso2ei::params::wso2_user,
  $wso2_group             = $wso2ei::params::wso2_group,
  $product_name           = $wso2ei::params::product_name,
  $product_version        = $wso2ei::params::product_version,
  $platform_version       = $wso2ei::params::platform_version,
  $carbon_home_symlink    = $wso2ei::params::carbon_home_symlink,
  $remote_file_url        = $wso2ei::params::remote_file_url,
  $maintenance_mode       = $wso2ei::params::maintenance_mode,
  $install_mode           = $wso2ei::params::install_mode,
  $install_dir            = $wso2ei::params::install_dir,
  $pack_dir               = $wso2ei::params::pack_dir,
  $pack_filename          = $wso2ei::params::pack_filename,
  $pack_extracted_dir     = $wso2ei::params::pack_extracted_dir,
  $patches_dir            = $wso2ei::params::patches_dir,
  $service_name           = $wso2ei::params::service_name,
  $service_template       = $wso2ei::params::service_template,
  $ipaddress              = $wso2ei::params::ipaddress,
  $enable_secure_vault    = $wso2ei::params::enable_secure_vault,
  $secure_vault_configs   = $wso2ei::params::secure_vault_configs,
  $key_stores             = $wso2ei::params::key_stores,
  $carbon_home            = $wso2ei::params::carbon_home,
  $pack_file_abs_path     = $wso2ei::params::pack_file_abs_path,
  $remove_file_list       = $wso2ei::params::remove_file_list,
  $analytics              = $wso2ei::params::analytics,
  $broker                 = $wso2ei::params::broker,
  $product_profile        = $wso2ei::params::product_profile,

  # business-process profile specific configuration data
  $so_timeout                                 = $wso2ei::params::so_timeout,
  $connection_timeout                         = $wso2ei::params::connection_timeout,
  $max_timeout                                = $wso2ei::params::mex_timeout,
  $external_service_timeout                   = $wso2ei::params::external_service_timeout,
  $max_connections_per_host                   = $wso2ei::params::max_connections_per_host,
  $max_total_connections                      = $wso2ei::params::max_total_connections,
  $ode_scheduler_thread_pool_size             = $wso2ei::params::ode_scheduler_thread_pool_size,
  $scheduler_config_max_thread_pool_size      = $wso2ei::params::scheduler_config_max_thread_pool_size,
  $enable_humantask_caching                   = $wso2ei::params::enable_humantask_caching,
  $activiti_datasources                       = $wso2ei::params::activiti_datasources,
  $bps_datasources                            = $wso2ei::params::bps_datasources,
  $taskServerCount                            = $wso2ei::params::taskServerCount,

  # broker profile specific configuration data
  $mb_thrift_server     = $wso2ei::params::mb_thrift_server,
  $mb_thrift_port       = $wso2ei::params::mb_thrift_port,

  # analytics profile specific configuration data
  $analytics_datasources   = $wso2ei::params::analytics_datasources,
  $spark                   = $wso2ei::params::spark,
  $is_datasource           = $wso2ei::params::is_datasource,
  $ha_deployment           = $wso2ei::params::ha_deployment,
  $portal                  = $wso2ei::params::portal,

  $metrics_datasources  = $wso2ei::params::metrics_datasources,
  
  # Templated configuration parameters
  $master_datasources     = $wso2ei::params::master_datasources,
  $registry_mounts        = $wso2ei::params::registry_mounts,
  $hostname               = $wso2ei::params::hostname,
  $mgt_hostname           = $wso2ei::params::mgt_hostname,
  $worker_node            = $wso2ei::params::worker_node,
  $usermgt_datasource     = $wso2ei::params::usermgt_datasource,
  $local_reg_datasource   = $wso2ei::params::local_reg_datasource,
  $clustering             = $wso2ei::params::clustering,
  $dep_sync               = $wso2ei::params::dep_sync,
  $ports                  = $wso2ei::params::ports,
  $jvm                    = $wso2ei::params::jvm,
  $fqdn                   = $wso2ei::params::fqdn,
  $sso_authentication     = $wso2ei::params::sso_authentication,
  $user_management        = $wso2ei::params::user_management
) inherits wso2ei::params {

  if $ei_wsdl_epr_prefix != undef {
    validate_hash($ei_wsdl_epr_prefix)
  }
  validate_hash($master_datasources)
  if $registry_mounts != undef {
    validate_hash($registry_mounts)
  }
  if $analytics != undef {
    validate_hash($analytics)
  }
  if $broker != undef {
    validate_hash($broker)
  }
  validate_string($hostname)
  validate_string($mgt_hostname)
  validate_bool($worker_node)
  validate_string($usermgt_datasource)
  validate_string($local_reg_datasource)
  validate_hash($clustering)
  validate_hash($dep_sync)
  validate_hash($ports)
  validate_hash($jvm)
  validate_string($fqdn)
  validate_hash($sso_authentication)
  validate_hash($user_management)

  class { '::wso2base':
    packages               => $packages,
    template_list          => $template_list,
    file_list              => $file_list,
    remove_file_list       => $remove_file_list,
    patch_list             => $patch_list,
    cert_list              => $cert_list,
    system_file_list       => $system_file_list,
    directory_list         => $directory_list,
    hosts_mapping          => $hosts_mapping,
    java_home              => $java_home,
    java_prefs_system_root => $java_prefs_system_root,
    java_prefs_user_root   => $java_prefs_user_root,
    vm_type                => $vm_type,
    wso2_user              => $wso2_user,
    wso2_group             => $wso2_group,
    product_name           => $product_name,
    product_version        => $product_version,
    platform_version       => $platform_version,
    carbon_home_symlink    => $carbon_home_symlink,
    remote_file_url        => $remote_file_url,
    maintenance_mode       => $maintenance_mode,
    install_mode           => $install_mode,
    install_dir            => $install_dir,
    pack_dir               => $pack_dir,
    pack_filename          => $pack_filename,
    pack_extracted_dir     => $pack_extracted_dir,
    patches_dir            => $patches_dir,
    service_name           => $service_name,
    service_template       => $service_template,
    ipaddress              => $ipaddress,
    enable_secure_vault    => $enable_secure_vault,
    secure_vault_configs   => $secure_vault_configs,
    key_stores             => $key_stores,
    carbon_home            => $carbon_home,
    pack_file_abs_path     => $pack_file_abs_path
  }

  contain wso2base
  contain wso2base::system
  contain wso2base::clean
  contain wso2base::install
  contain wso2base::configure
  contain wso2base::service

  Class['::wso2base'] -> Class['::wso2base::system']
  -> Class['::wso2base::clean'] -> Class['::wso2base::install']
  -> Class['::wso2base::configure'] ~> Class['::wso2base::service']
}
