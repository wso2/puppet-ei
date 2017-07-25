# WSO2 Enterprise Integrator Pattern-8

![pattern-design](../../../../../patterns/design/wso2ei-6.1.1-pattern-8.png)

This pattern consists of Broker profile cluster deployment. There are two nodes and wka (Well-Known-Address) membership scheme used in Hazelcast. You can change it to aws if deployment in EC2. Only carbon management console accessible via a load balancer. JMS traffic always routes to the first node and if the first node dies, then JMS client failover to the second node.

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
pattern=pattern-8

```

Ex: To setup first Business process profile node

```yaml
product_name=wso2ei
product_version=6.1.1
product_profile=broker1
environment=dev
vm_type=openstack
use_hieradata=true
platform=default
pattern=pattern-8

```
