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

# Claas ei_integrator::params
# This class includes all the necessary parameters.
class ei_integrator::params {
  $user = 'wso2carbon'
  $user_group = 'wso2'
  $product = 'wso2ei'
  $product_version = '6.5.0'
  $service_name = "${product}-${profile}"
  # $local_ip = $::ipaddress

  # JDK Distributions
  if $::osfamily == 'redhat' {
    $lib_dir = "/usr/lib64/wso2"
  }
  elsif $::osfamily == 'debian' {
    $lib_dir = "/usr/lib/wso2"
  }
  $jdk_name = 'amazon-corretto-8.202.08.2-linux-x64'
  $java_home = "${lib_dir}/${jdk_name}"

  # Define the template
  $start_script_template = "bin/integrator.sh"

  # Define the template
  $template_list = [
    'conf/datasources/master-datasources.xml',
    'conf/carbon.xml',
    'conf/axis2/axis2.xml',
    'conf/user-mgt.xml',
  ]

  # ------ Configuration Params ------ #

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
  $transport_receiver_keystore_location = 'repository/resources/security/wso2carbon.jks'
  $transport_receiver_keystore_type = 'JKS'
  $transport_receiver_keystore_password = 'wso2carbon'
  $transport_receiver_keystore_key_password = 'wso2carbon'

  $transport_receiver_trust_store_location = 'repository/resources/security/client-truststore.jks'
  $transport_receiver_trust_store_type = 'JKS'
  $transport_receiver_trust_store_password = 'wso2carbon'

  $transport_sender_keystore_location = 'repository/resources/security/wso2carbon.jks'
  $transport_sender_keystore_type = 'JKS'
  $transport_sender_keystore_password = 'wso2carbon'
  $transport_sender_keystore_key_password = 'wso2carbon'

  $transport_sender_trust_store_location = 'repository/resources/security/client-truststore.jks'
  $transport_sender_trust_store_type = 'JKS'
  $transport_sender_trust_store_password = 'wso2carbon'

  $hostname = 'localhost'
  $mgt_hostname = 'localhost'

  # ----- axis2.xml config params -----
  $clustering_enabled = 'false'
  $clustering_membership_scheme = 'multicast'
}
