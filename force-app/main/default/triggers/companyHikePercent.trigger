trigger companyHikePercent on Company__c (after insert) {
    for (Company__c company : Trigger.new) {
        if (company.HikePercent__c != null) {
            List<Employee__c> employeesToUpdate = [SELECT Id, Salary__c FROM Employee__c WHERE Company__c = :company.id];
            for (Employee__c employee : employeesToUpdate) {
                Decimal updatedSalary = employee.Salary__c * (1 + (company.HikePercent__c / 100));
                employee.Salary__c = updatedSalary;
            }
            update employeesToUpdate;
        }
    }
}