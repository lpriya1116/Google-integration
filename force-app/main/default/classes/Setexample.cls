public class Setexample {
    public Employee__c emp;
    public Department__c dept;
    public List<Employee__c> EmployeeList { get; set; }

    public void setmethod() {
        Set<Id> hrdept = new set<Id>();
        Set<Id> itdept = new set<Id>();
        Set<Id> Accountdept = new set<Id>();
        Set<Id> salesdept = new set<Id>();

        EmployeeList = [SELECT Employee_ID__c, Name,Department__r.id,Department__r.Dept_name__c FROM Employee__c];

        for (Employee__c d : EmployeeList) {
            if (d.Department__r.Dept_name__c == 'Hr') {
                hrdept.add(d.Department__r.id);
            } else if (d.Department__r.Dept_name__c == 'IT') {
                itdept.add(d.Department__r.id);
            } else if (d.Department__r.Dept_name__c== 'Accounts') {
                Accountdept.add(d.Department__r.id);
            } else if (d.Department__r.Dept_name__c == 'Sales') {
                salesdept.add(d.Department__r.id);
            }
        
//String deptName = [select dept_name__c from department__c where id in :hrdept].dept_name__c;
        
            }
         System.debug('Hr department id : ' + hrdept);
        System.debug('IT department id: ' + itdept);
        System.debug('Account department id: ' + Accountdept);
        System.debug('Sales department id: ' + salesdept);
    }
}