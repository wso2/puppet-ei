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

# Claas ei_msf4j::params
# This class includes all the necessary parameters.
class ei_msf4j::params {
  $user = 'wso2carbon'
  $user_id = 802
  $user_group = 'wso2'
  $user_home = '/home/$user'
  $user_group_id = 802
  $product = 'wso2ei'
  $product_version = '6.3.0'
  $profile = 'msf4j'
  $service_name = "${product}-${profile}"
  $jre_version = 'jre1.8.0_172'

  # Define the template
  $start_script_template = "wso2/msf4j/bin/carbon.sh"
  $template_list = [
    'wso2/msf4j/conf/transports/netty-transports.yml',
    'wso2/msf4j/conf/data-bridge/data-agent-config.xml',
  ]

  # ------ Configuration Params ------ #

  # netty-transports.yaml
  $host = '0.0.0.0'

  # data-agent-config.xml
  $thrift_agent_trust_store = 'conf/data-bridge/client-truststore.jks'
  $thrift_agent_trust_store_password = 'wso2carbon'

  $binary_agent_trust_store = 'conf/data-bridge/client-truststore.jks'
  $binary_agent_trust_store_password = 'wso2carbon'
}
