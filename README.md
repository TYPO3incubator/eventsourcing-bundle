# TYPO3 CMS Event Sourcing Bundle

## In a nutshell

* https://www.slideshare.net/slideshow/typo3-event-sourcing/68245192 (TYPO3camp Rhein-Ruhr, 2016)
* the database table `sys_event_store` contains all event streams for any record
* multiple database connections are maintained automatically (using Doctrine DBAL)
  + "Origin": this is basically the plain source, as we still know it in 2024;
    in the scope of event-sourcing it is NOT to be used anymore
  + "Default": these are all events projected (materialized) into a SQL database;
    modifications usually should happen via commands, events, etc. - this is the
    "compatibility layer" for the SQL world know - direct modifying SQL operations
    (update, delete, insert) are intercepted and transformed into events automatically
  + "LocalStorage::workspace-0: this is an independent, automatically projected context
    for a particular workspace, it does not contain any workspace overlays anymore, just
    the materialized entities for that particular workspace
* `\TYPO3\CMS\DataHandling\DataHandling\Interceptor\Hook\Backend\DataHandlerHook` and
  `\TYPO3\CMS\DataHandling\Core\Compatibility\DataHandling\DataHandlerTranslator` are
  doing all the magic, turning the legacy `DataHandler` data structures into commands,
  aggregates and finally events
    
## Installation

Configure your web-server to point to directory
`./eventsourcing-bundle/www/`. All other requirements for installing
TYPO3 CMS have to be fulfilled for the infrastructure as well.

### Clone this repository & install

```
git clone git@github.com:TYPO3Incubator/eventsourcing-bundle.git
cd eventsourcing-bundle

ddev start
ddev import-db -f .ddev/db.sql.gz
```

A new TYPO3 instance is being installed using the TYPO3 console.
Besides that the extensions `version`, `workspaces`, `bootstrap_package`,
`introduction`, `event_sourcing` and `data_handling` are installed

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
