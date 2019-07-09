#----------------------------------------------------------------------------
#  Copyright (c) 2019 WSO2, Inc. http://www.wso2.org
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
#----------------------------------------------------------------------------

class ei_common::params {

  $packages = ["unzip"]
  $version = "6.5.0"
  $pack = "wso2ei-${version}"

  # Set the location the product packages should reside in (eg: "local" in the /files directory, "remote" in a remote location)
  $pack_location = "local"
  # $pack_location = "remote"
  # $remote_jdk = "<URL_TO_JDK_FILE>"
  # $remote_pack = "<URL_TO_EI_PACK>"

  $user = 'wso2carbon'
  $user_group = 'wso2'
  $user_id = 802
  $user_group_id = 802

  # Performance tuning configurations
  $enable_performance_tuning = false
  $performance_tuning_flie_list = [
    'etc/sysctl.conf',
    'etc/security/limits.conf',
  ]

  # JDK Distributions
  $java_dir = "/opt"
  $java_symlink = "${java_dir}/java"
  $jdk_name = 'amazon-corretto-8.202.08.2-linux-x64'
  $java_home = "${java_dir}/${jdk_name}"

  $profile = $profile
  $target = "/mnt"
  $product_dir = "${target}/${profile}"
  $pack_dir = "${target}/${profile}/packs"
  $wso2_service_name = "wso2${profile}"

  # Pack Directories
  $carbon_home = "${product_dir}/${pack}"
  $product_binary = "${pack}.zip"

  # ----- Profile configs -----
  case $profile {
    'ei_analytics_dashboard': {
      $server_script_path = "${carbon_home}/wso2/analytics/wso2/dashboard/bin/carbon.sh"
      $pid_file_path = "${carbon_home}/wso2/analytics/wso2/dashboard/runtime.pid"
    }
    'ei_analytics_worker': {
      $server_script_path = "${carbon_home}/wso2/analytics/wso2/worker/bin/carbon.sh"
      $pid_file_path = "${carbon_home}/wso2/analytics/wso2/worker/runtime.pid"
    }
    'ei_integrator': {
      $server_script_path = "${carbon_home}/bin/integrator.sh"
      $pid_file_path = "${carbon_home}/wso2carbon.pid"
    }
    'ei_bps': {
      $server_script_path = "${carbon_home}/wso2/business-process/bin/wso2server.sh"
      $pid_file_path = "${carbon_home}/wso2/business-process/wso2carbon.pid"
    }
    'ei_broker': {
      $server_script_path = "${carbon_home}/wso2/broker/bin/wso2server.sh"
      $pid_file_path = "${carbon_home}/wso2/broker/wso2carbon.pid"
    }
  }

  # Server stop retry configs
  $try_count = 5
  $try_sleep = 5

  # ----- Master-datasources config params -----
  $carbon_db_url = 'jdbc:h2:./repository/database/WSO2CARBON_DB;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000'
  $carbon_db_username = 'wso2carbon'
  $carbon_db_password = 'wso2carbon'
  $carbon_db_driver = 'org.h2.Driver'
  $carbon_db_validation_query = 'SELECT 1'

  $wso2am_db_url = 'jdbc:h2:repository/database/WSO2AM_DB;DB_CLOSE_ON_EXIT=FALSE'
  $wso2am_db_username = 'wso2carbon'
  $wso2am_db_password = 'wso2carbon'
  $wso2am_db_driver = 'org.h2.Driver'
  $wso2am_db_validation_query = 'SELECT 1'

  $stat_db_url = 'jdbc:h2:../tmpStatDB/WSO2AM_STATS_DB;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000;AUTO_SERVER=TRUE'
  $stat_db_username = 'wso2carbon'
  $stat_db_password = 'wso2carbon'
  $stat_db_driver = 'org.h2.Driver'
  $stat_db_validation_query = 'SELECT 1'

  $mb_store_db_url = 'jdbc:h2:repository/database/WSO2MB_DB;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000'
  $mb_store_db_username = 'wso2carbon'
  $mb_store_db_password = 'wso2carbon'
  $mb_store_driver = 'org.h2.Driver'
  $mb_store_db_validation_query = 'SELECT 1'


  # ----- user-mgt.xml config params -----
  $admin_username = 'admin'
  $admin_password = 'admin'

  # -------------- Deployment.yaml Config -------------- #

  # Configuration used for the databridge communication
  $databridge_keystore = '${sys:carbon.home}/resources/security/wso2carbon.jks'
  $databridge_keystore_password = 'wso2carbon'
  $binary_data_receiver_hostname = '0.0.0.0'

  # Configuration of the Data Agents - to publish events through
  $thrift_agent_trust_store = '${sys:carbon.home}/resources/security/client-truststore.jks'
  $thrift_agent_trust_store_password = 'wso2carbon'
  $binary_agent_trust_store = '${sys:carbon.home}/resources/security/client-truststore.jks'
  $binary_agent_trust_store_password = 'wso2carbon'

  # Secure Vault Configuration
  $securevault_key_store = '${sys:carbon.home}/resources/security/securevault.jks'
  $securevault_private_key_alias = 'wso2carbon'
  $securevault_secret_properties_file = '${sys:carbon.home}/conf/${sys:wso2.runtime}/secrets.properties'
  $securevault_master_key_reader_file = '${sys:carbon.home}/conf/${sys:wso2.runtime}/master-keys.yaml'

  # Data Sources Configuration
  $metrics_db_url = 'jdbc:h2:${sys:carbon.home}/wso2/dashboard/database/metrics;AUTO_SERVER=TRUE'
  $metrics_db_username = 'wso2carbon'
  $metrics_db_password = 'wso2carbon'
  $metrics_db_driver = 'org.h2.Driver'

  $permission_db_url = 'jdbc:h2:${sys:carbon.home}/wso2/${sys:wso2.runtime}/database/PERMISSION_DB;IFEXISTS=TRUE;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000;MVCC=TRUE'
  $permission_db_username = 'wso2carbon'
  $permission_db_password = 'wso2carbon'
  $permission_db_driver = 'org.h2.Driver'

  $ei_analytics_db_url = 'jdbc:h2:${sys:carbon.home}/wso2/worker/database/EI_ANALYTICS;AUTO_SERVER=TRUE'
  $ei_analytics_db_username = 'wso2carbon'
  $ei_analytics_db_password = 'wso2carbon'
  $ei_analytics_db_driver = 'org.h2.Driver'
}