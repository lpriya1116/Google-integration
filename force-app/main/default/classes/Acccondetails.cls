public class Acccondetails {
    public List<WrapAccount> wrapAccountList { get; set; }
    public List<Account> selectedAccounts { get; set; }
    public List<Contact> selectedContacts { get; set; } 
 //i m from vs
    public Acccondetails() {
        wrapAccountList = new List<WrapAccount>();
        for (Account a : [SELECT Id, Name, BillingCity, Phone, (SELECT Id, FirstName, LastName, Email FROM Contacts) FROM Account LIMIT 10]) {
            wrapAccountList.add(new WrapAccount(a));
        }
        System.debug('wrapAccountList:' + wrapAccountList);
    }

    public void selectAccount() {
        selectedAccounts = new List<Account>();
        selectedContacts = new List<Contact>(); 

        for (WrapAccount obj : wrapAccountList) {
            if (obj.isSelected == true) {
                selectedAccounts.add(obj.accn);
                selectedContacts.addAll(obj.associatedContacts); 
            }
        }
    }

    public class WrapAccount {
        public Account accn { get; set; }
        public Boolean isSelected { get; set; }
        public List<Contact> associatedContacts { get; set; }

        public WrapAccount(Account a) {
            accn = a;
            isSelected = false;
            associatedContacts = new List<Contact>();
            if (a.Contacts != null) {
                for (Contact c : a.Contacts) {
                    associatedContacts.add(c);
                }
            }
        }
    }
}