public class EmployeeDetlsList {
    
    public  list<Employee__c> employees{
    get{
        employees = [select Name,salary__c,contact_number__c from Employee__c];
        return employees;
    }
    
      set;  
    }

}