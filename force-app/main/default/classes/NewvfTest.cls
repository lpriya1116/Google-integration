@IsTest
public class NewvfTest {
    @TestSetup
    static void TestNewvf() {
        Department__c testDepartment = new Department__c();
        insert testDepartment;

        List<Employee__c> testEmployees = new List<Employee__c>{
            new Employee__c(Name = 'Employee 1', Department__c = testDepartment.Id, contact_number__c = '1236549875'),
            new Employee__c(Name = 'Employee 2', Department__c = testDepartment.Id, contact_number__c = '1236549879'),
            new Employee__c(Name = 'Employee 3', Department__c = testDepartment.Id, contact_number__c = '1236549874')
        };
        insert testEmployees;
    }

    @IsTest
    static void testAddRow() {
        Department__c testDepartment = [SELECT Id, Name FROM Department__c];
        ApexPages.StandardController stdController = new ApexPages.StandardController(testDepartment);
        Newvf controller = new Newvf(stdController);

        Integer initialCount = controller.EmployeeList.size();

        controller.addRow();

        Integer newCount = controller.EmployeeList.size();
        System.assertEquals(initialCount + 1, newCount);
    }
   @IsTest
    static void testAddRow2() {
        Department__c testDepartment = [SELECT Id, Name FROM Department__c];
        ApexPages.StandardController stdController = new ApexPages.StandardController(testDepartment);
        Newvf controller = new Newvf(stdController);

        Integer initialCount = controller.EmployeeList.size();

        controller.addRow();

        Integer newCount = controller.EmployeeList.size();
        System.assertEquals(initialCount + 1, newCount);
    }

    @IsTest
    static void testDeleteRow() {
        Department__c testDepartment = [SELECT Id, Name FROM Department__c LIMIT 1];
        ApexPages.StandardController stdController = new ApexPages.StandardController(testDepartment);
        Newvf controller = new Newvf(stdController);

        Integer initialCount = controller.EmployeeList.size();
                System.assertEquals(initialCount, initialCount);
         controller.addRow();
        ApexPages.currentPage().getParameters().put('rowIndex', '0');
        controller.deleteRow();
        Integer newCount = controller.EmployeeList.size();
        System.assertEquals(initialCount, newCount);
    }

    @IsTest
    static void testSave() {
        
        Department__c testDepartment = [SELECT Id, Name FROM Department__c LIMIT 1];
        ApexPages.StandardController stdController = new ApexPages.StandardController(testDepartment);
        Newvf controller = new Newvf(stdController);
       Integer initialCount = controller.EmployeeList.size();
        controller.addRow();
        controller.save();
      Integer newCount = controller.EmployeeList.size();
        System.assertEquals(initialCount + 1, newCount);
    }
}