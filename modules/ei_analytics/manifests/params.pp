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

# Claas ei_analytics::params
# This class includes all the necessary parameters.
class ei_analytics::params {
  $user = 'wso2carbon'
  $user_id = 802
  $user_group = 'wso2'
  $user_home = '/home/$user'
  $user_group_id = 802
  $product = 'wso2ei'
  $product_version = '6.4.0'
  $profile = 'analytics'
  $hostname = 'localhost'
  $service_name = "${product}-${profile}"
  $mgt_hostname = 'localhost'
  $jdk_version = 'jdk1.8.0_192'

  # Define the template
  $start_script_template = "wso2/analytics/bin/wso2server.sh"
  $template_list = [
    'wso2/analytics/conf/datasources/analytics-datasources.xml',
    'wso2/analytics/conf/carbon.xml',
    'wso2/analytics/conf/axis2/axis2.xml',
    'wso2/analytics/conf/user-mgt.xml',
    # 'wso2/analytics/conf/datasources/master-datasources.xml',
    # 'wso2/analytics/conf/registry.xml',
    # 'wso2/analytics/conf/identity/identity.xml',
    # 'wso2/analytics/conf/security/authenticators.xml',
    # 'wso2/analytics/conf/tomcat/catalina-server.xml',
  ]

  # ------ Configuration Params ------ #

  # analytics-datasources.xml
  $event_store_db_url = 'jdbc:h2:repository/database/ANALYTICS_EVENT_STORE;AUTO_SERVER=TRUE;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000'
  $event_store_db_username = 'wso2carbon'
  $event_store_db_password = 'wso2carbon'
  $event_store_db_driver = 'org.h2.Driver'

  $processed_data_store_db_url = 'jdbc:h2:repository/database/ANALYTICS_PROCESSED_DATA_STORE;AUTO_SERVER=TRUE;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000'
  $processed_data_store_db_username = 'wso2carbon'
  $processed_data_store_db_password = 'wso2carbon'
  $processed_data_store_db_driver = 'org.h2.Driver'

  # carbon.xml
  $security_keystore_location = '${carbon.home}/repository/resources/security/wso2carbon.jks'
  $security_keystore_type = 'JKS'
  $security_keystore_password = 'wso2carbon'
  $security_keystore_key_alias = 'wso2carbon'
  $security_keystore_key_password = 'wso2carbon'

  $security_trust_store_location = '${carbon.home}/repository/resources/security/client-truststore.jks'
  $security_trust_store_type = 'JKS'
  $security_trust_store_password = 'wso2carbon'

  # axis2.xml
  $clustering_enabled = 'false'
  $clustering_wka_members = [
    { hostname => '127.0.0.1', port => '4000'},
    # { hostname => '127.0.0.1', port => '4001'},
  ]

  # user-mgt.xml
  $admin_username = 'admin'
  $admin_password = 'admin'
}
