# WSO2 Enterprise Integrator Pattern-6

![pattern-design](../../../../../patterns/design/wso2ei-6.1.1-pattern-6.png)

This pattern consists of Integrator profile and Analytics profile cluster deployment. Both cluster use wka (Well-Known-Address) membership scheme. You can change it to aws if deployment in EC2. The artifacts synchronization is done through Rsync. A load balancer used to distribute the traffic. The Integrator published statistics to Analytics via thrift protocol. Hence the following section should update with hostname/IP of VMs where Analytics instances running.

## integrator1.yaml file

```yaml
wso2::analytics:
  enabled : true
  payloads_stats: true
  properties_stats: true
  all_artifacts_stats: true
  server_username : admin
  server_password : admin
  analytics_cluster:
    group1:
      -
        hostname: localhost
        port: 7612
      -
        hostname: localhost
        port: 7612

```
Make sure to repeat same in integrator2.yaml file.

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
pattern=pattern-6

```

Ex: To setup first Integrator profile node

```yaml
product_name=wso2ei
product_version=6.1.1
product_profile=integrator1
environment=dev
vm_type=openstack
use_hieradata=true
platform=default
pattern=pattern6

```
