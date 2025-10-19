# organizer

- ✓ VarTransaction entries need optional reference to FixTransaction entry
- ✓ Compensation becomes topic
- ✓ AddVarTransaction needs Button to make list of compensations (VarTransactions) with each entry having to set category, topic and value. Rest of VarTransaction creation for compensation is done internally with given data.
- ✓ VarTransaction entry needs List< VarTransaction >? compensations.
- Same for FixTransaction: FixTransaction entry needs List< Dict < Topic, int > >? compensation
-> When FixTransaction creates VarTransaction it also creates VarTransaction for compensations ahead (like writen before)

- UI:  
Topic: Details, Overview month (+, -, rest, awaited to pay), FixTransaction cards (active and inactive), VarTransaction table with filter options  
Category: Topic cards (Title, description, Overview month)  
Dashboard: Overview month general, Topic cards of favorites  
Seperate designs mobile and desktop  

- Core:
Create archive / import logic  
Build base synching logic