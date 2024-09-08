# Azure IAM setup script.

### Steps to execute the script.
1. Open azure cloud shell
2. Execute: `bash <( curl -Ls https://raw.githubusercontent.com/akshay-tetration/connectors/main/azure/iam_setup_v1.sh )`
3. The above command executes with the default mode: `iam` and the interactive flag set to `false`

### Script options
```
Usage: -m <mode> -i <interactive>
  -m, --mode          Mode of operation (iam(default) or cleanup)
  -i, --interactive   Interactive mode (true or false(default))
```
