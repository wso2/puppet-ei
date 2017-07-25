# WSO2 Enterprise Integrator Pattern-9

![pattern-design](../../../../../patterns/design/wso2ei-6.1.1-pattern-9.png)

This pattern consists of Integrator profile and Broker profile cluster deployment. Both cluster use wka (Well-Known-Address) membership scheme. You can change it to aws if deployment in EC2. Integrator cluster artifacts synchronization is done through Rsync. A load balancer used to distribute the HTTP/HTTPS traffic. JMS proxy or Message store connect to the Broker cluster via JMS protocol. If first broker node dies, then JMS client failover to the second node. The following section should update with hostname/IP of VMs where Broker instances running.

## integrator1.yaml file

```yaml
wso2::broker:
  enable: true
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
pattern=pattern-9

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
pattern=pattern-9

```
