public with sharing class Contactcontrollerlwc {
    @AuraEnabled(cacheable=true)
    public static List<Contact> conlist() {
        return [SELECT Id, Lastname, Firstname, Phone FROM Contact LIMIT 10];
    }

   
}
