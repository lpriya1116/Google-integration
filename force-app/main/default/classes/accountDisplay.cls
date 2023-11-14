public class accountDisplay{
list<wrapAccount>acclist {get;set;}
list<Account>accounts {get;set;}
list<Contact>contacts{get;set;}

public accountDisplay{
list<wrapAccount>acclist =[select Id,Name,(select FirstName,LastName from Contacts) from Account];
list<Account>accounts = new list<Account>();
list<contact>contacts = new list<contact>();
}

public static void getAccount(){
  for ( Account a: acclist){
    if (isSelected == true){
        Account acc = a.AccountName

    }

  }
    


}

public class wrapAccount{
Account acc;
Boolean isSelected;
 public wrapAccount(Account a){ 
    acc = a;
    isSelected = false;
    list<Contact>associatedContacts = new list<Contact>;
    if(a.contact!=null){
        for(contact c :a.contact){
            associatedContacts.add(c);
        }
    }

    
 }

contact c : a.contact;
c.add(associatedContacts);

}


}