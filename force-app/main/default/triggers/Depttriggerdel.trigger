trigger Depttriggerdel on Department__c (before delete) {
        List<Employee__c> employeesToDelete = new List<Employee__c>();

    for (Department__c dept : Trigger.old) {
   List<Employee__c> employees = [SELECT Id FROM Employee__c WHERE Department__c = :dept.Id];
        
        employeesToDelete.addAll(employees);
}

    delete employeesToDelete;
}