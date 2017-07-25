# WSO2 Enterprise Integrator Pattern-2

![pattern-design](../../../../../patterns/design/wso2ei-6.1.1-pattern-2.png)

This pattern consists of a standalone Integrator and Analytics profile deployment. The Integrator push statistics to the Analytics. Make sure to enable analytics and change server host where analytics server up and running. Note that you have to provide hostname/IP of the VM where analytics instance running since statistics published via thrift protocol.

## integrator.yaml file

```yaml
wso2::analytics:
  enabled : true
  payloads_stats: true
  properties_stats: true
  all_artifacts_stats: true
  server_host : localhost
  server_port : 7612
  server_username : admin
  server_password : admin

```

Please follow the basic instructions in this [README](../../../../../README.md) before following this guide.

Content of /opt/deployment.conf file should be similar to below to run the agent and setup this pattern in Puppet Agent.

## deployment.conf file

```yaml
product_name=wso2ei
product_version=6.1.1
product_profile=<hiera_file_name_without_extension>
environment=dev
vm_type=openstack
use_hieradata=true
platform=default
pattern=pattern-4

```

Ex: To setup first Integrator profile node

```yaml
product_name=wso2ei
product_version=6.1.1
product_profile=integrator
environment=dev
vm_type=openstack
use_hieradata=true
platform=default
pattern=pattern-4

```
