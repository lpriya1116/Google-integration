public class Employeedisplay
{
    //this is for testing
    public list<Employee__c> employeeList { get; set; }
    public String ID;
    public String Name;
    Public String Salary;
       
    
    public  void showDetails()
    {
        employeeList = [Select Employee_ID__c,Name,Salary__c From Employee__c];
            System.debug('employeeList' +employeeList);
        }
     
    
        public void deleteDetails() {
    try {
        Employee__c emp = [SELECT Employee_ID__c, Name, Salary__c FROM Employee__c WHERE Name = 'Priya' LIMIT 1];
        if (emp != null) {
            Delete emp;
        } else {
            System.debug('No Employee record found with Name = Priya');
        }
    } catch (Exception e) {
        System.debug('Error deleting Employee record: ' + e.getMessage());
    }
}
}