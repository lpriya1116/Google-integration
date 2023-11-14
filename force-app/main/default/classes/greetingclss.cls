public class greetingclss {
    public List<Contact> contacts { get; set; }
    
    public greetingclss(ApexPages.StandardController controller) {
        // Get the Account Id from the page parameter
        String accountId = ApexPages.currentPage().getParameters().get('id');
        
        // Query the contacts associated with the Account
        contacts = [SELECT Name, Email, Phone FROM Contact WHERE AccountId = :accountId];
    }
}