#!/bin/bash
./typo3cms install:setup --site-setup-type=no
./typo3cms extension:activate --extension-keys=version,workspaces,bootstrap_package,introduction,data_handling
