# organizer

- ✓ VarTransaction entries need optional reference to FixTransaction entry
- ✓ Compensation becomes topic
- ✓ AddVarTransaction needs Button to make list of compensations (VarTransactions) with each entry having to set category, topic and value. Rest of VarTransaction creation for compensation is done internally with given data.
- ✓ VarTransaction entry needs List< VarTransaction >? compensations.
- ✓ VarTransaction (if being a compensation) needs a id reference to the compensated VarTransaction
- ✓ Same for FixTransaction: FixTransaction entry needs List< Dict < Topic, int > >? compensation
-> When FixTransaction creates VarTransaction it also creates VarTransaction for compensations ahead (like writen before)
- ✓ Proper removing logic needs to be implemented
- ✓ Compensation needs to be available from topics from other categories
- ✓ Add edit fix transaction dialogs
- ✓ Show compensations dialog
- ✓ Properly set up TransactionLabels in add loggig and settings to control.
- ✓ Added users and file references for future safety.
- ✓ Overview ui element
- ✓ Split overview_elemnt into multiple classes
- ✓ Overview for category
- ✓ Overview Dashboard
-  Var transaction table needs media control
- ✓ Options element needs styling and filter logic for backend
- ✓ Properly include FixTransactionelement
- ✓ Implement automatic fixtransaction execution on app startup and checking on loading topic (check latest date)
- ✓ Check properly deleting any of the database tables (remove references, or cascade deletion)
- ✓ User needs color property
- ✓ Transactionlabel needs color property
- ✓ Visualize user in VarTransaction and FixTransaction
-  Redention user in overview
- ✓ Summary card split in expenses and additions
- ✓ Global date selection (from and to filtering)

- UI:  
Topic: Details, Overview month (+, -, rest, awaited to pay), FixTransaction cards (active and inactive), VarTransaction table with filter options  
Category: Topic cards (Title, description, Overview month)  
Dashboard: Overview month general, Topic cards of favorites  
Seperate designs mobile and desktop  

- Core:
Create archive / import logic  
Build base synching logic