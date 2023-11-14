trigger DepartmentTrigger on Department__c (after update) {
    List<Employee__c> employeesToUpdate = new List<Employee__c>();

    for (Department__c dept : Trigger.new) {
        Department__c oldDept = Trigger.oldMap.get(dept.Id);
                        system.debug('sal');
        system.debug('olddept  '+oldDept);
                system.debug('oldhikedept  '+oldDept.hikePercent__c);
                system.debug('oldhikedept1  '+dept.hikePercent__c);


        if (oldDept != null && oldDept.hikePercent__c != dept.hikePercent__c) {
          
            List<Employee__c> employees = [SELECT Id, salary__c FROM Employee__c WHERE Department__c = :dept.Id];
            for (Employee__c emp : employees) {
                system.debug('sal'+emp.salary__c);
                Decimal currentsalary = emp.salary__c;
                                system.debug('cursal'+currentsalary);

                Decimal newsalary = currentsalary * (1 + (dept.hikePercent__c / 100));
                                                system.debug('newsal'+newsalary);

               emp.salary__c = newsalary;
                employeesToUpdate.add(emp);
            }
        }
    }

    if (!employeesToUpdate.isEmpty()) {
        update employeesToUpdate;
    }
}