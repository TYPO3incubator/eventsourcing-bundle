# TYPO3 CMS Event Sourcing Bundlung

## Installation

Configure your web-server to point to directory
`./eventsourcing-bundle/www/`. All other requirements for installing
TYPO3 CMS have to be fulfilled for the infrastructure as well.

### Clone this repository & install

```
git clone git@github.com:TYPO3Incubator/eventsourcing-bundle.git
cd eventsourcing-bundle
composer install
```

### Install TYPO3 & extensions

A new TYPO3 instance is being installed using the TYPO3 console.
Besides that the extensions version, workspaces, bootstrap_package,
introduction and data_handling are installed

```
./install.sh
```

### Upgrade schema & events

Open the Install Tool and
* execute `compare current database with specification` in the
  `important actions` section, create all new `t3uuid` and `t3rev` fields
* execute `initialize events for existing records` in the `upgrade wizard`
  section, wait until all events for existing records have been determined
  - this could take some time

## Bank Account Example

In addition you can enable the `bank_account_example`, create a new page
and put the accordant frontend pluging for the bank account example on
that page.

## Infrastructure

* events are stored in the MySQL table `sys_event_store`
* additional SQLite databases are created in `typo3temp/var/LocalStorage/`
