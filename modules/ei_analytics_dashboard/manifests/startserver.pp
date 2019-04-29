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

# Class ei_analytics_dashboard::startserverÒ
# Starts the server as a service in the final stage.
class ei_analytics_dashboard::startserver inherits ei_analytics_dashboard::params {

  exec { 'daemon-reload':
    command => "systemctl daemon-reload",
    path    => "/bin/",
  }

  # Start the service
  service { $service_name:
    enable    => true,
    ensure    => running,
    subscribe => File["binary"],
  }
}
