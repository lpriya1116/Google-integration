public class Newemployee {
    public Employee__c employee { get; set; }
    public List<Employee__c> employees { get; set; }
    public Id selectedEmployeeId { get; set; }
    public Boolean editMode { get; set; }

    // Add a constructor with ApexPages.StandardController parameter
    public Newemployee() {
        employee = new Employee__c();
        refreshEmployees();
    }

    private void refreshEmployees() {
        employees = [SELECT Id, Name, salary__c, contact_number__c, Department__c FROM Employee__c];
    }

    public PageReference navigateToNewemployee1() {
        editMode = false;
        employee = new Employee__c();
        PageReference pageRef = Page.Newemployee1;
        pageRef.setRedirect(true);
        return pageRef;
    }

    public PageReference editEmployee() {
        editMode = true;
        employee = [SELECT Id, Name, salary__c, contact_number__c, Department__c FROM Employee__c WHERE Id = :selectedEmployeeId];
        PageReference pageRef = Page.Newemployee1;
        pageRef.setRedirect(true);
        return pageRef;
    }

    public PageReference saveEmployee() {
        if (editMode) {
            update employee;
        } else {
            insert employee;
        }
        refreshEmployees(); // Update the list of employees after saving.
        return Page.Newvf2;
    }

    public PageReference cancel() {
        return Page.Newvf2;
    }
}