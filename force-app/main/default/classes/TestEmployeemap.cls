@isTest
public class TestEmployeemap {
    @isTest
    static void TestEmployeemapmethod(){
        List<Employee__c> testEmployees = new List<Employee__c>{
            new Employee__c(Name ='Abc', contact_number__c='9087986789',Department__c ='a062t00000doedCAAQ'),
            new Employee__c(Name ='Def', contact_number__c='9087986789',Department__c ='a062t00000doedCAAQ'),
            new Employee__c(Name ='Ghi', contact_number__c='9087986789',Department__c ='a062t00000doedCAAQ')
        };
        insert testEmployees;

        Employeemap empmap = new Employeemap();
        empmap.employeemapmethod();

        Map<ID, List<Employee__c>> departmentEmployeeMap = empmap.departmentEmployeeMap;
        Set<ID> departmentIds = empmap.departmentIds;

        System.debug('Department IDs: ' + departmentIds);
        System.debug('departmentEmployeeMap: ' + departmentEmployeeMap);

        List<Employee__c> employeesInDept = empmap.getEmployeesByDepartmentId('a062t00000doedCAAQ');
        System.debug('Employees in Dept a062t00000doedCAAQ: ' + employeesInDept);

        
    }
}