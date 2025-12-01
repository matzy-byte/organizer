# organizer
Local organization application for management of finance and file storage, as well as secure data transmission via mutiple devices, to synchronize changes on the go.

## How to use
### Getting started
Install the application on your device. When running the application for the first time you will be guided through the setup process.
Explanation of the applications most important components are listedd down below.

### Adding items
Using the floating action button you can open dialogs to create several components, which are also easily to configure in the dialog.

### Deleting items
Whenever you delete an item you will be asked to confirm in an alert dialog. This is an critical change for the synchronization process.

### Synchronization
The application can be run on desktop and mobile. It is highly recommended to make the desktop the master of the entire usage.
The mobile version should be used to make changes on the go and synchronize them fast at home.
However the synchronization can be done both ways.
The main control is on the desktop, here you can also set a check for also deleting items which are missing.
This enforces that the synchronization master will force the synchronization listener to delete all items that the master doesn't contain.

### Backup
Local applications can always fail. Backup is relatively simple by backing up the organizer.sqlite file, which is in the same folder als the executable.

## To Dos
- Set settings in setup screen
- Rework responsive layouts for mobile
- Add proper settings page (better way to delete categories and control settings)
- Add edit dialog for user, category and topic

## Components
Those are the most important components, which might not be self explanatory. The examples used are in the same context: "Manage household purchases"  

### Category
This is a container for multiple items - Just like a folder that contains multiple files.  
Example: Household

### Topic
This is an item to which data can be attached - Just like a file that contains data.  
Example: Purchases (Topic of Category "Household")

### Transaction
Defines an actual financial transaction and assigns it the currently used user.