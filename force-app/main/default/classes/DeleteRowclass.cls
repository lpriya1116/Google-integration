public class DeleteRowclass {
    public Employee__c emp;
    public Department__c dep;
    public List <Employee__c> addEmployeeList { get; set; }
    public List <Employee__c> delEmployeeList { get; set; }
    public List <Employee__c> employeeList { get; set; }
    public Integer totalCount { get; set; }
    public Integer rowIndex { get; set; }

    public DeleteRowclass(ApexPages.StandardController controller) {
        dep = (Department__c) controller.getRecord();
        employeeList = [SELECT Employee_ID__c, Name, salary__c, Department__c, contact_number__c FROM Employee__c];
        totalCount = employeeList.size();
        delEmployeeList = new List <Employee__c>();
        addEmployeeList = new List <Employee__c>();
    }
    public void addRow() {
     employeeList.add(new Employee__c(Name = dep.Name));
        }
     public PageReference save() {
        upsert employeeList;
        //delete delEmployeeList;
        PageReference pageRef = new PageReference('/lightning/o/Employee__c/list');
        pageRef.setRedirect(true);
        return pageRef;
    }

    public void deleteRow() {
        Integer rowIndex = Integer.valueOf(ApexPages.currentPage().getParameters().get('rowIndex'));
        if (rowIndex >= 0 && rowIndex < employeeList.size()) {
            delEmployeeList.add(employeeList.remove(rowIndex));
        } else if (employeeList.size() > 0) {
            delEmployeeList.add(employeeList.remove(employeeList.size() - 1));
             delete delEmployeeList;
        }
    }
}