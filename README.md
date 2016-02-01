#  MyPlaces – Vertabelo Mobile ORM example app
The example iOS app that laverages the Vertabelo Mobile ORM to add and manage places in the SQLite database.

## Overview

The app does the following:
- Displays a list of places retrieved from the SQLite database,
- Enables to perform sorting and filtering operations,
- Shows details of the selected item with possibility to edit/delete it.

For connection to database stands listed below components:
- **MobiORM package** – generated Java classes that maps the database model and classes with defined operations for creating, reading, updating and deleting objects in/from a database. 
- `PlaceManager` -  class that is responsible for managing places (insert, delete, update, select)
- `TagsManager` – class that handles inserting, deleting tags.
- `AddressManager` – class that manages countries and cities associated with the places.

## Documentation

To find more information on how to use Vertabelo Mobile ORM, visit:
<br>
 http://mobile-orm.vertabelo.com/docs/vertabelo-mobile-orm-docs.html
