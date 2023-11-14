public class Listmapemployee {
    
    public Map<ID, List<Employee__c>> employeedeptlistMethod() {
        Map<Id, Employee__c> mEmp = new Map<Id, Employee__c>([SELECT Id, Name, Department__c FROM Employee__c]);
        Map<Id, List<Employee__c>> mdept = new Map<Id, List<Employee__c>>(); // Change the value type to List<Employee__c>
         Set<Id> departmentIds = new Set<Id>(); // Initialize a set to store unique Department Ids

        for (Id idval : mEmp.keySet()) {
            system.debug(+idval);
            Employee__c emp = mEmp.get(idval);
            ID deptId = emp.Department__c;

            if (deptId != null) {
                if (!mdept.containsKey(deptId)) {
                    mdept.put(deptId, new List<Employee__c>());
                }
                mdept.get(deptId).add(emp);
                departmentIds.add(deptId); // Add the Department Id to the set

            }
        }

        System.debug('mdept' + mdept);
        return mdept;
    }
}