public class EmployeeController {
    public Employee__c selectedEmployee { get; set; }
    public String selectedEmployeeId { get; set; } 
    public Department__c dep;
    public list < Employee__c > dltemployees {get;set;}
    public List<EmployeeWrapper> employeesWrapper { get; set; }

    public EmployeeController(ApexPages.StandardController controller) {
    dep = (Department__c)controller.getRecord();
    List<Employee__c> employeeRecords = [SELECT Id, Name, Department__c, contact_number__c, salary__c FROM Employee__c];
    employeesWrapper = new List<EmployeeWrapper>();
    for (Employee__c employee : employeeRecords) {
    employeesWrapper.add(new EmployeeWrapper(employee, false));
    }
}


    public PageReference editEmployee() {
        selectedEmployee = [SELECT Id, Name, Department__c, contact_number__c, salary__c FROM Employee__c WHERE Id = :selectedEmployeeId];
       
       return Page.EmployeeFormPage;
    }
     public PageReference saveEmployee() {
        update selectedEmployee;
        PageReference pageRef = new PageReference('/apex/EmployeeDetailspage');
        pageRef.setRedirect(true);
        return pageRef;
    }

    public PageReference cancelEdit() {
        return Page.EmployeeDetailsPage;
    }

    public void DeleteChecked() {    
    dltemployees = new List<Employee__c>();
    List<EmployeeWrapper> updatedEmployeesWrapper = new List<EmployeeWrapper>();
    
    for (EmployeeWrapper cc : employeesWrapper) {
        if (cc.checked && cc.employee.Id != null) {
            dltemployees.add(cc.employee);
        } else {
            updatedEmployeesWrapper.add(cc); 
        }
    }
    
    if (dltemployees.size() > 0) {
        delete dltemployees;
        employeesWrapper = updatedEmployeesWrapper; 
       PageReference pageRef = new PageReference('/apex/EmployeeDetailspage');
        pageRef.setRedirect(true);
       
    }
}
            public PageReference savedeletedEmployee(){
            PageReference pageRef = new PageReference('/lightning/o/Employee__c/list');
            pageRef.setRedirect(true);
            return pageRef;

    }

       
    public class EmployeeWrapper {
    public Employee__c employee {get; set;}
    public Boolean checked {get; set;}
    public EmployeeWrapper(Employee__c employee, Boolean checked){
        this.employee = employee;
        this.checked = checked;
    }
}    
}