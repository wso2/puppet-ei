# WSO2 Enterprise Integrator 6.3.0 Puppet 5 Modules

This repository contains puppet modules for each profile relates to Enterprise Integrator.

## Quick Start Guide
1. Download and copy the `wso2ei-linux-installer-x64-6.3.0.deb` or/and `wso2ei-linux-installer-x64-6.3.0.rpm` to the files directories in `/etc/puppet/code/environments/dev/modules/__profile__/files` in the Puppetmaster. <br>
Profile refers to each profile in Enterprise Integrator. <br>
eg: `/etc/puppet/code/environments/dev/modules/ei_integrator/files` <br>
Dev refers to the sample environment that you can try these modules.

2. Run necessary profile on puppet agent. More details on this are available in the following section.

## Running Enterprise Integrator Profiles in Puppet Agent
This section describes how to run each profile in a puppet agent.

### Integrator profile
```bash
export FACTER_profile=ei_integrator
puppet agent -vt
```

### Broker profile
```bash
export FACTER_profile=ei_broker
puppet agent -vt
```

### Business Process profile
```bash
export FACTER_profile=ei_bps
puppet agent -vt
```

### Analytics profile
```bash
export FACTER_profile=ei_analytics
puppet agent -vt
```

### Micro Integrator profile
```bash
export FACTER_profile=ei_micro_integrator
puppet agent -vt
```

### MSF4J profile
```bash
export FACTER_profile=ei_msf4j
puppet agent -vt
```

## Understanding the Project Structure
In this project each profle of Enterprise Integrator is mapped to a module in puppet. By having this structure each puppet module is considered as a standalone profile so each module can be configured individually without harming any other module.

```
puppet-ei
├── manifests
│   └── site.pp
└── modules
    ├── ei_integrator
    │   ├── files
    │   │   └── ...
    │   ├── manifests
    │   │   ├── init.pp
    │   │   ├── custom.pp
    │   │   ├── params.pp
    │   │   └── startserver.pp
    │   └── templates
    │       └── ...
    ├── ei_broker
    │   ├── files
    │   │   └── ...
    │   ├── manifests
    │   │   ├── init.pp
    │   │   ├── custom.pp
    │   │   ├── params.pp
    │   │   └── startserver.pp
    │   └── templates
    │       └── ...
    ├── ei_bps
    │   ├── files
    │   │   └── ...
    │   ├── manifests
    │   │   ├── init.pp
    │   │   ├── custom.pp
    │   │   ├── params.pp
    │   │   └── startserver.pp
    │   └── templates
    │       └── ...
    ├── ei_analytics
    │   ├── files
    │   │   └── ...
    │   ├── manifests
    │   │   ├── init.pp
    │   │   ├── custom.pp
    │   │   ├── params.pp
    │   │   └── startserver.pp
    │   └── templates
    │       └── ...
    ├── ei_micro_integrator
    │   ├── files
    │   │   └── ...
    │   ├── manifests
    │   │   ├── init.pp
    │   │   ├── custom.pp
    │   │   ├── params.pp
    │   │   └── startserver.pp
    │   └── templates
    │       └── ...
    └── ei_msf4j
        ├── files
        │   └── ...
        ├── manifests
        │   ├── init.pp
        │   ├── custom.pp
        │   ├── params.pp
        │   └── startserver.pp
        └── templates
            └── ...

```

### Manifests in a module
Each puppet module contains following pp files
- init.pp <br>
This contains the main script of the module.
- custom.pp <br>
This is used to add custom user code to the profile.
- params.pp <br>
This contains all the necessary parameters for main configurations and template rendering.
- startserver.pp <br>
This runs finally and starts the server as a service.
=======
