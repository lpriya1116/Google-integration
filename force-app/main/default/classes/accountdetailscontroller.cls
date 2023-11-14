public with sharing class accountdetailscontroller {
@AuraEnabled(cacheable=true)
public static List<Account>acclist(){
    return [SELECT Id, Name,Phone,Rating FROM  Account];
    
}
}