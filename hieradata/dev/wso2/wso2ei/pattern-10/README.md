# WSO2 Enterprise Integrator Pattern-10

![pattern-design](../../../../../patterns/design/wso2ei-6.1.1-pattern-10.png)

This pattern consists of Integrator profile, Analytics profile and Broker profile cluster deployment. All cluster use wka (Well-Known-Address) membership scheme. You can change it to aws if deployment in EC2. The artifacts synchronization is done through Rsync. A load balancer used to distribute the HTTP/HTTPS traffic. The Integrator published statistics to Analytics via thrift protocol. Hence the following section should update with hostname/IP of VMs where Analytics instances running.

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

JMS proxy or Message store connect to the Broker cluster via JMS protocol. If first broker node dies, then JMS client failover to the second node. The following section should update with hostname/IP of VMs where Broker instances running.

## integrator1.yaml file

```yaml
wso2::broker:
  enabled: true
  server_username : admin
  server_password : admin
  broker_cluster:
    -
      hostname: localhost
      port: 5675
    -
      hostname: localhost
      port: 5675

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
pattern=pattern-10

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
pattern=pattern-10

```
