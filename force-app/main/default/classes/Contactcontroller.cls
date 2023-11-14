public class Contactcontroller {
    @AuraEnabled
    public static list<Contact> getContacts(){
        return [select Id,lastname,firstname,phone,Account.Name from Contact limit 10];
        
    }
 @AuraEnabled
public static Contact createContactWithAccount(String firstName, String lastName, String email, String phone, String accountName) {
     Account newAccount = new Account();
    newAccount.Name = 'testaccount';
        insert newAccount;

        Contact newContact = new Contact();
        newContact.FirstName = firstName;
        newContact.LastName = lastName;
        newContact.Email = email;
        newContact.Phone = phone;
        newContact.AccountId = accountName;

        insert newContact;
        return newContact;
    }
    @AuraEnabled
   public static List<Account> getAvailableAccounts() {
    return [SELECT Id, Name FROM Account LIMIT 10]; 
}
     @AuraEnabled
    public static void updateContacts(List<Contact> contacts) {
        update contacts;
    }
  @AuraEnabled
public static void deleteContacts(List<String> contactIds) {
    try {
        List<Contact> contactsToDelete = [SELECT Id FROM Contact WHERE Id IN :contactIds];
        delete contactsToDelete;
    } catch (Exception e) {
        throw new AuraHandledException('Error deleting contacts: ' + e.getMessage());
    }
}
    
    

}