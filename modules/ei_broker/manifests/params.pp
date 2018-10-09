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

# Claas ei_broker::params
# This class includes all the necessary parameters.
class ei_broker::params {
  $user = 'wso2carbon'
  $user_id = 802
  $user_group = 'wso2'
  $user_home = '/home/$user'
  $user_group_id = 802
  $product = 'wso2ei'
  $product_version = '6.4.0'
  $profile = 'broker'
  $hostname = 'localhost'
  $service_name = "${product}-${profile}"
  $mgt_hostname = 'localhost'
  $jdk_version = 'jdk1.8.0_192'

  # Define the template
  $start_script_template = "wso2/broker/bin/wso2server.sh"
  $template_list = [
    'wso2/broker/conf/broker.xml',
    'wso2/broker/conf/datasources/master-datasources.xml',
    'wso2/broker/conf/carbon.xml',
    'wso2/broker/conf/axis2/axis2.xml',
    'wso2/broker/conf/user-mgt.xml',
    # 'wso2/broker/conf/registry.xml',
    # 'wso2/broker/conf/identity/identity.xml',
    # 'wso2/broker/conf/security/authenticators.xml',
    # 'wso2/broker/conf/tomcat/catalina-server.xml',
  ]

  # ------ Configuration Params ------ #

  # broker.xml
  $amqp_keystore_location = 'repository/resources/security/wso2carbon.jks'
  $amqp_keystore_password = 'wso2carbon'
  $amqp_keystore_cert_type = 'SunX509'

  $amqp_trust_store_location = 'repository/resources/security/client-truststore.jks'
  $amqp_trust_store_password = 'wso2carbon'
  $amqp_trust_store_cert_type = 'SunX509'

  $mqtt_keystore_location = 'repository/resources/security/wso2carbon.jks'
  $mqtt_keystore_password = 'wso2carbon'
  $mqtt_keystore_cert_type = 'SunX509'

  $mqtt_trust_store_location = 'repository/resources/security/client-truststore.jks'
  $mqtt_trust_store_password = 'wso2carbon'
  $mqtt_trust_store_cert_type = 'SunX509'

  # master-datasources.xml
  $carbon_db_url = 'jdbc:h2:repository/database/WSO2CARBON_DB;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000'
  $carbon_db_username = 'wso2carbon'
  $carbon_db_password = 'wso2carbon'
  $carbon_db_driver = 'org.h2.Driver'

  $mb_store_db_url = 'jdbc:h2:repository/database/WSO2MB_DB;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000'
  $mb_store_db_username = 'wso2carbon'
  $mb_store_db_password = 'wso2carbon'
  $mb_store_db_driver = 'org.h2.Driver'

  # carbon.xml
  $security_keystore_location = '${carbon.home}/repository/resources/security/wso2carbon.jks'
  $security_keystore_type = 'JKS'
  $security_keystore_password = 'wso2carbon'
  $security_keystore_key_alias = 'wso2carbon'
  $security_keystore_key_password = 'wso2carbon'

  $security_internal_keystore_location = '${carbon.home}/repository/resources/security/wso2carbon.jks'
  $security_internal_keystore_type = 'JKS'
  $security_internal_keystore_password = 'wso2carbon'
  $security_internal_keystore_key_alias = 'wso2carbon'
  $security_internal_keystore_key_password = 'wso2carbon'

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
