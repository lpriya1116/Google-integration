public class Displayemployees {
     public Employee__c emp;
    public List < Employee__c > employeeList {get;set;}
    public List<SelectOption> employees { get; set; }
    public String selectedEmployeeId { get; set; }

    public Displayemployees(ApexPages.StandardController controller) {
        employees = new List<SelectOption>();
        EmployeeList  = [Select Employee_ID__c, Name, salary__c,Department__c,contact_number__c from Employee__c]; 
             for (Employee__c emp : EmployeeList) {
            employees.add(new SelectOption(emp.Id, emp.Name));
        }
    }
}