public class Employeemap {
    public Map<ID, List<Employee__c>> departmentEmployeeMap { get; set; }
    public Set<ID> departmentIds { get; set; }

    public Employeemap(){
        departmentEmployeeMap = new Map<ID, List<Employee__c>>();
        departmentIds = new Set<ID>();
        employeemapmethod();
    }

    public void employeemapmethod() {
        List<Employee__c> employees = [SELECT Id, Name, Department__c FROM Employee__c];
        for (Employee__c emp : employees) {
            ID deptid = emp.Department__c;
            if (!departmentEmployeeMap.containsKey(deptid)) {
                departmentEmployeeMap.put(deptid, new List<Employee__c>{ emp });
                departmentIds.add(deptid); 
            } else {
                departmentEmployeeMap.get(deptid).add(emp);
            }
        }

        System.debug('Department IDs: ' + departmentIds);
        System.debug('departmentEmployeeMap: ' + departmentEmployeeMap);
    }
    
    public List<Employee__c> getEmployeesByDepartmentId(ID deptId) {
        if (departmentEmployeeMap.containsKey(deptId)) {
            return departmentEmployeeMap.get(deptId);
        } else {
            return new List<Employee__c>();
        }
    }
}