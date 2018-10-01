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

# Claas ei_bps::params
# This class includes all the necessary parameters.
class ei_bps::params {
  $user = 'wso2carbon'
  $user_id = 802
  $user_group = 'wso2'
  $user_home = '/home/$user'
  $user_group_id = 802
  $product = 'wso2ei'
  $product_version = '6.4.0'
  $profile = 'business-process'
  $hostname = 'localhost'
  $service_name = "${product}-${profile}"
  $mgt_hostname = 'localhost'
  $jdk_version = 'jdk1.8.0_192'

  # Define the template
  $start_script_template = "wso2/business-process/bin/wso2server.sh"
  $template_list = [
    'wso2/business-process/conf/carbon.xml',
    'wso2/business-process/conf/axis2/axis2.xml',
    'wso2/business-process/conf/user-mgt.xml',
    # 'wso2/business-process/conf/datasources/master-datasources.xml',
    # 'wso2/business-process/conf/registry.xml',
    # 'wso2/business-process/conf/identity/identity.xml',
    # 'wso2/business-process/conf/security/authenticators.xml',
    # 'wso2/business-process/conf/tomcat/catalina-server.xml',
  ]

  # ------ Configuration Params ------ #

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
