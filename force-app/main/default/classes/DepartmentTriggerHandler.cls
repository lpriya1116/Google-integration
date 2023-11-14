public class DepartmentTriggerHandler {

    public static void updateDept(List<Department__c> newList, Map<Id, Department__c> oldMap) {
        List<Employee__c> empUpdates = new List<Employee__c>();

        for (Department__c newDept : newList) {
            if (newDept != null && newDept.Id != null) {
                Department__c oldDept = oldMap.get(newDept.Id);

                if (oldDept == null) {
                    System.debug('oldDept is null for Department__c Id: ' + newDept.Id);
                }

                if (oldDept != null && newDept.hikePercent__c != oldDept.hikePercent__c) {
                    Decimal hikePercent = 1 + (newDept.hikePercent__c / 100);
                    List<Employee__c> employeesToUpdate = [SELECT Id, Salary__c FROM Employee__c WHERE Department__c = :newDept.Id];
if (!employeesToUpdate.isEmpty()) {
    for (Employee__c emp : employeesToUpdate) {
        Decimal currentSalary = emp.Salary__c;
        System.debug('Current Salary: ' + currentSalary);
        Decimal newsalary = currentSalary * hikePercent;
        emp.Salary__c = newsalary;
        empUpdates.add(emp);
    }
}
                }
            }
        }

        if (!empUpdates.isEmpty()) {
            update empUpdates;
        }
    }
}