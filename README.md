# WSO2 Enterprise Integrator Puppet Module

This repository contains the Puppet Module for installing and configuring WSO2 Enterprise Integrator on various environments. Configuration data is managed using [Hiera](http://docs.puppetlabs.com/hiera/1/). Heira provides a mechanism to separate the configuration data from puppet scripts and to manage them in a separate set of YAML files in a hierarchical manner.

## Supported Operating Systems

- Ubuntu 14.04 or higher
- RedHat Enterprise Linux 6.7

## Supported Puppet Versions

- Puppet 2.7, 3 or newer

## How to Contribute
Follow the steps mentioned in the [wiki](https://github.com/wso2/puppet-base/wiki) to setup a development environment and update/create new puppet modules.

## Running WSO2 Enterprise Integrator in stand-alone mode
WSO2 Enterprise Integrator consists of the following profiles: Integration profile, Business Process profile, Message Broker profile, and the Analytics profile. Each of these profiles can be configured and started in stand-alone mode using Puppet. No changes are required to Heira data in order to run these profiles in stand-alone mode.

You can simply copy the files to their corresponding locations as explained [here] (https://github.com/wso2/puppet-base/wiki) and apply the Puppet Modules as follows: https://github.com/wso2/puppet-base/wiki/Use-WSO2-Puppet-Modules-in-puppet-master-agent-Environment.

## Running WSO2 Enterprise Integrator with clustering in specific profiles

The clustering-related configurations that are shipped in each of the profiles of WSO2 EI (Integration profile, Business Process profile, Message Broker profile and the Analytics profile) has the required Hiera data enabled by default. Therefore, only a few additional changes are required in order to set up a distributed deployment using the WSO2 EI profiles as explained below.


1. If the Clustering Membership Scheme is `WKA`, add the Well Known Address list.
     Ex:
    ```yaml
    wso2::clustering:
        enabled: true
        domain: esb.wso2.domain
        local_member_host: "%{::ipaddress}"
        local_member_port: 4000
        membership_scheme: wka
        sub_domain: mgt
        wka:
           members:
             -
               hostname: 192.168.100.91
               port: 4000
             -
               hostname: 192.168.100.92
               port: 4000
    ```

2. Add external databases to master datasources.

   Ex:
    ```yaml
    wso2::master_datasources:
      wso2_config_db:
        name: WSO2_CONFIG_DB
        description: The datasource used for config registry
        driver_class_name: "%{hiera('wso2::datasources::mysql::driver_class_name')}"
        url: jdbc:mysql://192.168.100.1:3306/WSO2REG_DB?autoReconnect=true
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
3. Configure registry mounting.

   Ex:
    ```yaml
    wso2_config_db:
      path: /_system/config
      target_path: /_system/config/esb
      read_only: false
      registry_root: /
      enable_cache: true

    wso2_gov_db:
      path: /_system/governance
      target_path: /_system/governance
      read_only: false
      registry_root: /
      enable_cache: true
    ```

4. Configure deployment synchronization.

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
        secret_alias_value: repository/conf/carbon.xml//Server/Security/KeyStore/Password,false
        password: wso2carbon
    ```
3. Add Cipher Tool configuration file templates to `template_list`

    ```yaml
    wso2::template_list:
      - repository/conf/security/cipher-text.properties
      - repository/conf/security/cipher-tool.properties
      - bin/ciphertool.sh
    ```

     If the `vm_type` is not `docker` when you are running the server in stand-alone mode, be sure to add the `password-tmp` template to `template_list.


## Running WSO2 Enterprise Integrator on Kubernetes
WSO2 Enterprise Integrator Puppet module ships the Hiera data required for deploying the profiles of WSO2 Enterprise Integrator on Kubernetes. For more information, refer the documentation on [deploying WSO2 products on Kubernetes using WSO2 Puppet Modules](https://docs.wso2.com/display/PM210/Deploying+WSO2+Products+on+Kubernetes+Using+WSO2+Puppet+Modules).
