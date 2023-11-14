public class Newvf {
    public Employee__c Emp;
    public Department__c dep;
    public List <Employee__c> addEmployeeList { get; set; }
    public List <Employee__c> delEmployeeList { get; set; }
    public List <Employee__c> EmployeeList { get; set; }
    public Integer totalCount { get; set; }
    public Integer rowIndex { get; set; }

    public Newvf(ApexPages.StandardController controller) {
        dep = (Department__c) controller.getRecord();
        EmployeeList = [SELECT Employee_ID__c, Name, salary__c, Department__c, contact_number__c FROM Employee__c];
        totalCount = EmployeeList.size();
        delEmployeeList = new List <Employee__c>();
        addEmployeeList = new List <Employee__c>();
    }

    public void addRow() {
    Employee__c newEmployee = new Employee__c(
        Name = dep.Name,
        Department__c = dep.Id,
        contact_number__c = '9865325632'
    );
    EmployeeList.add(newEmployee);
}
    public PageReference save() {
        upsert EmployeeList;
        delete delEmployeeList;
        PageReference pageRef = new PageReference('/lightning/o/Employee__c/list');
        pageRef.setRedirect(true);
        return pageRef;
    }

    public void deleteRow() {
        Integer rowIndex = Integer.valueOf(ApexPages.currentPage().getParameters().get('rowIndex'));
        if (rowIndex >= 0 && rowIndex < EmployeeList.size()) {
            delEmployeeList.add(EmployeeList.remove(rowIndex));
        } else if (EmployeeList.size() > 0) {
            delEmployeeList.add(EmployeeList.remove(EmployeeList.size() - 1));
        }
    }
}