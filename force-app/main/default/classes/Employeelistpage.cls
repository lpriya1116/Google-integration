public class Employeelistpage {
    public String selectedEmployeeId { get; set; }
    public Employee__c emp { get; set; }
    public List<Employee__c> addEmployeeList { get; set; }
    public List<Employee__c> EmployeeList { get; set; }
    public Department__c dep;

   // public Employeelistpage () {
      //  EmployeeList = [SELECT Employee_ID__c, Name, salary__c, Department__c, contact_number__c FROM Employee__c];
       // addEmployeeList = new List<Employee__c>();
   // }

    public List<SelectOption> getEmployees() {
        List<SelectOption> options = new List<SelectOption>();
        for (Employee__c emp : EmployeeList) {
            options.add(new SelectOption(emp.Id, emp.Name));
        }
        return options;
    }

    public PageReference redirectToDetails() {
        PageReference EmployeedetailPage1 = Page.EmployeedetailPage1;
        EmployeedetailPage1.getParameters().put('id', selectedEmployeeId);
        EmployeedetailPage1.setRedirect(true);
        return EmployeedetailPage1;
    }

    public void addRow() {
        EmployeeList.add(new Employee__c(Name = dep.Name));
    }

    public PageReference saveEmployee() {
       // insert emp;
        PageReference EmployeelistPage1 = Page.EmployeelistPage1;
        EmployeelistPage1.setRedirect(true);
        return EmployeelistPage1;
    }

    public PageReference redirectToEmployeeList() {
        PageReference EmployeelistPage1 = Page.EmployeelistPage1;
        EmployeelistPage1.setRedirect(true);
        return EmployeelistPage1;
    }
}