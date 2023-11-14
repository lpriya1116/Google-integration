public class Empcrudoperation {
    @AuraEnabled
    public static List<Employee__c> getEmployees() {
    return [SELECT Id, Name,Salary__c FROM Employee__c];
    }
}