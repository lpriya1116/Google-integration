@isTest
public class EmployeehikedtlsTest {
    @isTest
    static void testDepthike() {
        // Create test Department records
        Department__c hrDepartment = new Department__c(Name = 'HR');
        Department__c managerDepartment = new Department__c(Name = 'manager');
        Department__c directorDepartment = new Department__c(Name = 'Director');
        Department__c developerDepartment = new Department__c(Name = 'Developer');
        
        insert new List<Department__c>{hrDepartment, managerDepartment, directorDepartment, developerDepartment};

        List<Employee__c> employees = new List<Employee__c>();
        employees.add(new Employee__c(Name = 'Emp1', Contact_Number__c = '9865528658', Department__c = hrDepartment.Id, Salary__c = 50000));
        employees.add(new Employee__c(Name = 'Emp2', Contact_Number__c = '9865528658', Department__c = managerDepartment.Id, Salary__c = 60000));
        employees.add(new Employee__c(Name = 'Emp3', Contact_Number__c = '9865528658', Department__c = directorDepartment.Id, Salary__c = 70000));
        employees.add(new Employee__c(Name = 'Emp4', Contact_Number__c = '9865528658', Department__c = developerDepartment.Id, Salary__c = 80000));
        insert employees;

        Employeehikedtls employeehikedtlsInstance = new Employeehikedtls();

        Set<Id> empIds = new Set<Id>();
        for (Employee__c emp : employees) {
            empIds.add(emp.Id);
        }
        employeehikedtlsInstance.empIds = empIds; 

        Test.startTest();

        employeehikedtlsInstance.depthike();
        List<Employee__c> updatedEmployees = [SELECT Id, Salary__c, Department__c FROM Employee__c WHERE Id IN :employeehikedtlsInstance.empIds];

        Test.stopTest();

       // List<Employee__c> updatedEmployees = [SELECT Id, Salary__c, Department__c FROM Employee__c WHERE Id IN :employeehikedtlsInstance.empIds];

        System.assertEquals(4, updatedEmployees.size());

        Decimal tolerance = 0.001; 
system.debug('updatedemp'+updatedEmployees);
        for (Employee__c emp : updatedEmployees) {
                        system.debug('empsal'+emp.Salary__c);
            system.debug('empdept'+emp.Department__c);

            Decimal hikePercentage = employeehikedtlsInstance.hikemap.get(emp.Department__c);
                        system.debug('hikePercentage'+hikePercentage);

            Decimal expectedSalary = emp.Salary__c * (1 + hikePercentage);
            system.debug('expexcted'+expectedSalary);
                        system.debug('expexc'+emp.Salary__c);
            system.debug('expexctedtol'+tolerance);

            System.assertEquals(expectedSalary, emp.Salary__c, tolerance);
        }
    }
}