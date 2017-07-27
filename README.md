# WSO2 Enterprise Integrator Puppet Module

This is the Puppet Module for installing and configuring WSO2 Enterprise Integrator in the 11 basic deployment patterns. First four patterns are standalone product profile deployment and rest of the patterns are HA deployment. Configuration data is managed using [Hiera](http://docs.puppetlabs.com/hiera/1/). Hiera provides a mechanism for separating configuration data from Puppet scripts and managing them in a set of YAML files in a hierarchical manner.

This guide includes the the basic and common information related to each deployment pattern. Follow the instructions here, to setup any deployment pattern. For specific information on each pattern, refer the relevant README file in each pattern related hieradata directory (i.e. for pattern 5 : puppet-ei/hieradata/dev/wso2/wso2ei/pattern-5/README.md)

1. [Pattern 1 - README](hieradata/dev/wso2/wso2ei/pattern-1/README.md)
2. [Pattern 2 - README](hieradata/dev/wso2/wso2ei/pattern-2/README.md)
3. [Pattern 3 - README](hieradata/dev/wso2/wso2ei/pattern-3/README.md)
4. [Pattern 4 - README](hieradata/dev/wso2/wso2ei/pattern-4/README.md)
5. [Pattern 5 - README](hieradata/dev/wso2/wso2ei/pattern-5/README.md)
6. [Pattern 6 - README](hieradata/dev/wso2/wso2ei/pattern-6/README.md)
7. [Pattern 7 - README](hieradata/dev/wso2/wso2ei/pattern-7/README.md)
8. [Pattern 8 - README](hieradata/dev/wso2/wso2ei/pattern-8/README.md)
9. [Pattern 9 - README](hieradata/dev/wso2/wso2ei/pattern-9/README.md)
10. [Pattern 10 - README](hieradata/dev/wso2/wso2ei/pattern-10/README.md)
11. [Pattern 11 - README](hieradata/dev/wso2/wso2ei/pattern-11/README.md)

Please note that the load balancer configurations are not done by puppet. HA deployment pattern images Ex: [pattern-5](https://github.com/wso2/docker-ei/tree/master/docker-compose/pattern-5) consist of load balancers so that it will be convenient to understand the connections when configured load balancing, which is usually done in a production environment.

## How to Contribute

Follow the steps mentioned in the [wiki](https://github.com/wso2/puppet-base/wiki) to setup a development environment and update/create new puppet modules.

## Setup Puppet Environment

* Setup the puppet environment with the puppet modules wso2ei, wso2common and wso2base.
* WSO2 EI 6.1.1 puppet modules are compatible and tested with [puppet-base](https://github.com/wso2/puppet-base/) 
version 1.0.0 and [puppet-common](https://github.com/wso2/puppet-common) version 1.0.0
* So if using puppet-common's setup.sh to setup the `PUPPET_HOME`, use this version (1.0.0) of puppet-common.
* After setting up `PUPPET_HOME` using puppet-common's setup.sh, checkout the above mentioned compatible version of puppet-base.

## Supported Operating Systems

- Debian 6 or higher
- Ubuntu 14.04

## Supported Puppet Versions

- Puppet 3.x

## Configuring WSO2 EI Integrator Profile

Patterns 1, 2, 5, 6, 9, 10 and 11 are configured with WSO2 EI Integrator profile.

## Configuring WSO2 EI Analytics Profile

Patterns 2, 6, 10 and 11 are configured with WSO2 EI Analytics profile.

## Configuring WSO2 EI Business Process Profile

Patterns 3, 7, 11 are configured with WSO2 EI Business process profile

## Configuring WSO2 EI Broker Profile

Patterns 9, 10 and 11 are configured with WSO2 EI Broker profile.

## Packs to be Copied

Copy the following files to their corresponding locations, in the Puppet Master.

1. WSO2 Enterprise Integrator 6.1.1 distribution (wso2ei-6.1.1.zip)to `<PUPPET_HOME>/modules/wso2ei/files`
2. JDK jdk-8u131-linux-x64.tar.gz distribution to `<PUPPET_HOME>/modules/wso2base/files`
3. (if using MySQL databases)MySQL JDBC driver JAR (`mysql-connector-java-x.x.xx-bin.jar`) into the `<PUPPET_HOME>/modules/wso2ei/files/configs/lib`
4. (if using svn based deployment synchronization)
    1. `svnkit-all-1.8.7.wso2v1.jar` into `<PUPPET_HOME>/modules/wso2ei/files/configs/dropins`
    2. `trilead-ssh2-1.0.0-build215.jar` into `<PUPPET_HOME>/modules/wso2ei/files/configs/lib`

## Running WSO2 Enterprise Integrator with clustering in specific profiles

Hiera data sets matching the distributed profiles of WSO2 Enterprise Integrator (`integrator`, `analytics`, `business-process`, `broker`) are shipped with clustering related configuration already enabled. Therefore, only a few changes are needed to setup a distributed deployment in your preferred deployment pattern, before running the puppet agent. For more details refer the [Clustering the Ennterprise Integrator](https://docs.wso2.com/display/EI611/Clustered+Deployment) docs.

Do the changes in hieradata .yaml files in the related pattern.

1. Update the host name

Make sure to update `wso2::hostname` and `wso2::mgt_hostname` in .yaml files of relevant pattern according to load balancer. If environment doesn't have load balancer, then make sure to add host name mapping to the /etc/hosts file. Puppet will add the required host entries explicitly in /etc/hosts file in the Agent. For that you have to add the hosts mappings appropriately in common.yaml (for patterns 5 to 11).

Ex:
   ```yaml
    wso2::hosts_mapping:
      integrator_host:
        ip: 192.168.57.186
        name: integrator.wso2.com
      integrator_mgt_host:
        ip: 192.168.57.186
        name: ui.integrator.wso2.com
   ```

2. Add the Well Known Address list for cluster.

Pattern 5-11 consists of clusters deployment of each profile. If you are using those patterns, update members list appropriately in relevant .yaml files. Refer each pattern's README for more info.

3. Modify the MySQL based data sources to point to the external MySQL servers in all the hiera data files. (You have just to replace the IP address, with the IP address of database server you are using). If you want to use any other database except MySQL, update the data sources appropriately.

   Ex:
    ```yaml
    wso2::master_datasources:
      wso2_config_db:
        name: WSO2_CONFIG_DB
        description: The datasource used for config registry
        driver_class_name: "%{hiera('wso2::datasources::mysql::driver_class_name')}"
        url: jdbc:mysql://192.168.100.1:3306/WSO2_CONFIG_DB?autoReconnect=true
        username: "%{hiera('wso2::datasources::mysql::username')}"
        password: "%{hiera('wso2::datasources::mysql::password')}"
        jndi_config: jdbc/WSO2_CONFIG_DB
        max_active: "%{hiera('wso2::datasources::common::max_active')}"
        max_wait: "%{hiera('wso2::datasources::common::max_wait')}"
        test_on_borrow: "%{hiera('wso2::datasources::common::test_on_borrow')}"
        default_auto_commit: "%{hiera('wso2::datasources::common::default_auto_commit')}"
        validation_query: "%{hiera('wso2::datasources::mysql::validation_query')}"
        validation_interval: "%{hiera('wso2::datasources::common::validation_interval')}"
    ```
    If MySQL databases are used, uncomment the file_list entry for JDBC connector jar in relevant hiera data files (In patterns 5-11 : common.yaml).

    ```yaml
    wso2::file_list:
      - "lib/%{hiera('wso2::datasources::mysql::connector_jar')}"
    ```
    And update the jar file name appropriately if your file name is not mysql-connector-java-5.1.39-bin.jar in 
    `<PUPPET_HOME>/hieradata/dev/wso2/common.yaml` (for patterns 5 to 11).

    ```yaml
    wso2::datasources::mysql::connector_jar: mysql-connector-java-5.1.39-bin.jar
    ```
4. Configure deployment synchronization in integrator, analytics and business-process clusters. This can be done via multiple approaches.

* SVN Based

Patterns 5-11 are configured for svn based deployment synchronization, but they are disabled out by default. Do enable them and update correct details.

Ex:
```yaml
    wso2::dep_sync:
        enabled: true
        auto_checkout: true
        auto_commit: true
        repository_type: svn
        svn:
           url: http://svnrepo.example.com/repos/
           user: username
           password: password
           append_tenant_id: true
```
Copy the required jars for svn, into respective locations as described under the topic **Packs to be Copied**. And add the file_list entries for those two jar files in those hiera data files related to cluster deployment.

```yaml
    wso2::file_list:
       -  "dropins/svnkit-all-1.8.7.wso2v1.jar"
       -  "lib/trilead-ssh2-1.0.0-build215.jar"
```

* Rsync

Note that WSO2 now recommends rsync instead of svn, for deployment synchronization. So if you prefer to use rsync follow the [WSO2 Docs on Configuring rsync for Deployment Synchronization](https://docs.wso2.com/display/CLUSTER44x/Configuring+rsync+for+Deployment+Synchronization)

## Running WSO2 Enterprise Integrator with Secure Vault

WSO2 Carbon products may contain sensitive information such as passwords in configuration files. [WSO2 Secure Vault](https://docs.wso2.com/display/Carbon444/Securing+Passwords+in+Configuration+Files) provides a solution for securing such information.

Uncomment and modify the below changes in Hiera file to apply Secure Vault.

1. Enable Secure Vault

    ```yaml
    wso2::enable_secure_vault: true
    ```

2. Add Secure Vault configurations as below

    ```yaml
    wso2::secure_vault_configs:
      <secure_vault_config_name>:
        secret_alias: <secret_alias>
        secret_alias_value: <secret_alias_value>
        password: <password>
    ```

    Ex:

    ```yaml
    wso2::secure_vault_configs:
      key_store_password:
        secret_alias: Carbon.Security.KeyStore.Password
        secret_alias_value: conf/carbon.xml//Server/Security/KeyStore/Password,false
        password: wso2carbon
    ```
    
3. Add Cipher Tool configuration file templates to `template_list`

    ```yaml
    wso2::template_list:
      - conf/security/cipher-text.properties
      - conf/security/cipher-tool.properties
      - bin/ciphertool.sh
    ```

Please add the `password-tmp` template also to `template_list` if the `vm_type` is not `docker` when you are running the server in `default` platform.

## Keystore and client-truststore related configs

This repository includes default keystore and clint-truststore in `<PUPPET_HOME>/modules/wso2ei/files/configs/repository/resources/security` for the initial setup (testing) purpose. This wso2carbon.jks keystore is created for CN=localhost, and its self signed certificate is imported into the client-truststore.jks. When running puppet agent, these two files replace the existing default wso2carbon.jks and client-truststore.jks files.

In the production environments, it is recommended to replace these with your own keystores and trust stores with CA signed certificates. Also if also you change the host names given by-default in these patterns, you have to create your own ones. For more info read [WSO2 Docs on Creating Keystores](https://docs.wso2.com/display/ADMIN44x/Creating+New+Keystores).

Following steps can be followed to create new keystore and clint-truststore with self signed certificates.

1 . Generate a Java keystore and key pair with self-signed certificate:
```
    keytool -genkey -alias wso2carbon -keyalg RSA -keysize 2048 -keystore wso2carbon.jks -dname "CN=*.integrator.wso2.com,OU=Home,O=Home,L=SL,S=WS,C=LK" -storepass wso2carbon -keypass wso2carbon -validity 2000
```
2 . Export a certificate from a keystore:
```
    keytool -export -keystore wso2carbon.jks -alias wso2carbon -file wso2carbon.cer
```
3 . Import a certificate into a trust store:
```
    keytool -import -alias wso2carbon -file wso2carbon.cer -keystore client-truststore.jks -storepass wso2carbon
```

