# Configuration File Management Script

## Overview:

This Bash script (config_manager.sh) simplifies the process of updating a configuration file (sig.conf). 
It guides the user through input validation and modifies the configuration file according to the provided values.

## Usage:

Running the Script:

Execute the script using Bash: bash conf_update.sh.

## Input Requirements:

The script prompts the user for the following inputs:

* Component Name: Choose from INGESTOR, JOINER, WRANGLER, VALIDATOR.

* Scale: Choose from MID, HIGH, LOW.

* View: Choose from Auction or Bid.

* Count: Enter a single digit number.

## Configuration File Update:

Upon successful validation, the script updates the configuration file (sig.conf) with the new values.

The file structure is: <view> ; <scale> ; <component name> ; ETL ; vdopia-etl= <count>

Example:-

Suppose the user provides the following inputs:

* Component Name: INGESTOR
* Scale: HIGH
* View: Auction
* Count: 3
* The script updates sig.conf with:

```bash
vdopiasample ; HIGH ; INGESTOR ; ETL ; vdopia-etl= 3 ; <current_date_time>
```

## Requirements:

Bash shell environment.

### Note:
* Ensure sig.conf exists in the same directory as the script.
* The script updates only one line in the configuration file at a time.
* Valid inputs are necessary to prevent errors in the configuration file.

For inquiries, vanshik0027@gmail.com.
