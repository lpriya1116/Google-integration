public class Employeehikedtls {
    public List<Employee__c> employeesList { get; set; }
    public Map<String, Decimal> hikemap { get; set; }
    public Map<String, List<Employee__c>> deptEmp { get; set; }
    public List<Employee__c> empDtls { get; set; }
    //public Decimal decimalValue = 0;
    public Set<Id> empIds = new Set<Id>();
    
    public void depthike() {
        hikemap = new Map<String, Decimal>();
        hikemap.put('HR', 0.05);
        hikemap.put('manager', 0.1);
        hikemap.put('Director', 0.07);
        hikemap.put('Developer', 0.15);


        employeesList = [SELECT Id, Name, contact_number__c, Department__c, Salary__c FROM Employee__c];
         
        system.debug('employeesList'+employeesList);
         
        deptEmp = new Map<String, List<Employee__c>>();
            
          
    for (String department : hikemap.keySet()) {
            //system.debug('dept1'+department);
         // system.debug('hikemap1' +hikemap);
           if (hikemap.containsKey(department))
            
      for (Employee__c emp : employeesList) {
    String department123 = emp.Department__c;
    //system.debug('department123 ' + department);
    if (!deptEmp.containsKey(department)) {
        deptEmp.put(department, new List<Employee__c>());
    }
    deptEmp.get(department).add(emp);
      }
        }
        empDtls = new List<Employee__c>();

       for (String departmentname : deptEmp.keyset()) {
          //system.debug('dept2' +departmentname);
          // system.debug('depatmentemployees' +deptEmp.values());
       
           //if (hikemap.containsKey(departmentname)) {
                      for (Employee__c emp : deptEmp.get(departmentname)) {
                          if (hikemap.containsKey(departmentname)){

              // system.debug('departmentname' +departmentname);
                Decimal hikePercentage = hikemap.get(departmentname);
               // system.debug(hikepercentage +hikePercentage);
                 Decimal currentSalary = emp.Salary__c;
                   Decimal newSalary = currentSalary * (1 + hikePercentage);
                   emp.Salary__c = newSalary;
                               if (!empIds.contains(emp.Id)) {
                empIds.add(emp.Id);
                empDtls.add(emp);
           }
                      }
                }
          if (!empDtls.isEmpty()) {
            update empDtls;
          }


            
        
      }
                                            System.debug('Employees after update: ' + empDtls);

            }
}