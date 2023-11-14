public class deletecontacts {

@AuraEnabled(Cacheable = true)
public static List<Contact> getContacts(){
return [SELECT Id, FirstName,LastName, Phone, Email FROM Contact ORDER BY Name];
}
    
@AuraEnabled
public static void deleteContacts(list<Id> lstConIds){
try {list<Contact> lstCons =[SELECT Id, FirstName,LastName, Phone, Email FROM Contact WHERE 
    id IN:lstConIds ];
    list<Contact> lstConsToDelete = new list<Contact>();
System.debug('lstConIds '+lstConIds);
 for(Contact idCon : lstCons) {
    system.debug('idcon' +idcon);
lstConsToDelete.add(idCon);
}
if(!lstConsToDelete.isEmpty()) {
delete lstConsToDelete;
}
}
catch(Exception ex) {
    system.debug(ex.getMessage());

throw new AuraHandledException(ex.getMessage());
        }
    }
}