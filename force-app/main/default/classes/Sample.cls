public class Sample {
    List<Employee__c> emp = new List<Employee__c>(); 

    public void getEmployees() {
        emp = [SELECT Id, Name, Salary__c FROM Employee__c];
        System.debug('Employee Details ' + emp);
    }

    public List<Employee__c> getEmployeesByName(String name) {
       // List<Employee__c> matchingEmployees = new List<Employee__c>();

        for (Employee__c employee : emp) {
            if (employee.Name == name) {
             // return emp.get(name);
            }
        }
        return null;

       // return matchingEmployees;
    }
}