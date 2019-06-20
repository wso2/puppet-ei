# Puppet Modules for WSO2 Enterprise Integrator

This repository contains the Puppet modules for WSO2 Enterprise Integrator and the profiles related to Enterprise Integrator Analytics.

## Quick Start Guide
1. Download an updated wso2ei-6.5.0.zip pack and copy it to the `<puppet_environment>/modules/ei_common/files/packs` directory in the **Puppetmaster**.

2. Set up the JDK distribution as follows:

   The Puppet modules for WSO2 products use Amazon Coretto as the JDK distribution. However, you can use any [supported JDK distribution](https://docs.wso2.com/display/compatibility/Tested+Operating+Systems+and+JDKs).
   1. Download Amazon Coretto for Linux x64 from [here](https://docs.aws.amazon.com/corretto/latest/corretto-8-ug/downloads-list.html) and copy .tar into the `<puppet_environment>/modules/ei_common/files/jdk` directory.
   2. Reassign the *$jdk_name* variable in `<puppet_environment>/modules/ei_common/manifests/params.pp` to the name of the downloaded JDK distribution.
5. Run the relevant profile on the **Puppet agent**.
    1. Integrator profile:
        ```bash
        export FACTER_profile=ei_integrator
        puppet agent -vt
        ```
    2. Business Process profile:
        ```bash
        export FACTER_profile=ei_bps
        puppet agent -vt
        ```
    3. Broker profile:
        ```bash
        export FACTER_profile=ei_broker
        puppet agent -vt
        ```
    4. Analytics profiles:
        1. Dashboard:
            ```bash
            export FACTER_profile=ei_analytics_dashboard
            puppet agent -vt
            ```
        2. Worker:
            ```bash
            export FACTER_profile=ei_analytics_worker
            puppet agent -vt
            ```

## Manifests in a module
The run stages for Puppet are described in `<puppet_environment>/manifests/site.pp`, and they are of the order Main -> Custom.

Each Puppet module contains the following .pp files.
* Main
    * params.pp: Contains all the parameters necessary for the main configuration and template
    * init.pp: Contains the main script of the module.
* Custom
    * custom.pp: Used to add custom configurations to the Puppet module.
    