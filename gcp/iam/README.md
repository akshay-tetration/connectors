# Google Cloud Platform (GCP) IAM Connector Setup

## Overview

This directory contains the utilities to set up the GCP Identity and Access Management (IAM) resources required for the Secure Workload GCP Connector. The setu pscript creates the necessary permissions, service accounts, principals, and custom roles that are required for Secure Workload to interact with GCP. 

## Prerequisites
- GCP Subscription
- GCP CLI installed locally or access to GCP Cloud Shell Editor
- Permissions to create custom roles, service accounts, and the necessary registrations

## Quick Start

The quickest way to set up the IAM resources is through the GCP Cloud Shell Editor: 

```bash
bash <(curl -Ls https://raw.githubusercontent.com/kartallu/connector/refs/heads/main/gcp_iam_v2_setup.sh)
```

This command will execute the script with default settings (non-interactive mode). 

## Script Options
The script supports the following command line options:

```
Usage: ./gcp_iam_v2_setup.sh -m <mode> -i <interactive> 
    -m, --mode                  Mode of operation (iam(default) or cleanup)
    -i, --interactive           Interactive mode (true or false(default))
```

### Modes
- **iam**: (Default option) Creates all required IAM resources including: 
    - Service account
    - Custom role with necessary permissions
    - Key JSON file
- **cleanup**: Deletes all resources created by the script. You will need to provide: 
    - Service account email
    - Custom role name 

### Interactive Mode
- **false**: (Default option) Uses auto-generated names for resources. 
- **true**: Prompts for the names to the service account and role name. 

## Examples

### Basic Setup (non-interactive)
```bash 
./gcp_iam_setup_v2.sh 
```

### Interactive Setup
```bash
./gcp_iam_setup_v2.sh -i true
```

### Cleanup Resources
```bash
./gcp_iam_setup_v2.sh -m cleanup
```

## Output
After the script is successfully executed, it should provide the following information: 
1. Credentials required for onboarding the GCP Connector: 
    - Activated service account
    - JSON file with private key and secret
    - Custom role name with necessary permissions

2. Information required for cleanup: 
    - Activated service account email
    - Custom role name 

Make sure to save this information in a secure way. You will need this information to: 
- Configure the Secure Workload GCP connector
- Clean up resources when they are no longer needed

## Permissions
The custom role that is created by this script includes permissions for: 
- Reading network, container, service account, and firewall policy resources
- Storage account access
- Resource group reads and access
- NSG management
- Flow log access

## Troubleshooting
If the script fails: 
- Check that you have the appropriate permissions in GCP
- Ensure that you are logged into the GCP CLI
- Check if resources already exist
- Review any error messages displayed by the script

