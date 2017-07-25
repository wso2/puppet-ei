# WSO2 Enterprise Integrator Pattern-1

![pattern-design](../../../../../patterns/design/wso2ei-6.1.1-pattern-1.png)

This pattern consists of a standalone Integrator profile deployment.

Please follow the basic instructions in this [README](../../../../../README.md) before following this guide.

Content of /opt/deployment.conf file should be similar to below to run the agent and setup this pattern in Puppet Agent.

## deployment.conf file

```yaml
product_name=wso2ei
product_version=6.1.1
product_profile=integrator
environment=dev
vm_type=openstack
use_hieradata=true
platform=default
pattern=pattern-1

```
