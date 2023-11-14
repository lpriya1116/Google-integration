trigger companyTrigger on Company__c (before insert) {
    Id userProfileId = userinfo.getProfileId();
    String userProfileName= [SELECT ID, Name from Profile Where Id = : userProfileId].Name;
    
    if( userProfileName == 'System Administrator' )
    {
        for(Company__c com : trigger.new)
        {
            com.adderror('Insufficient access -  You dont have access to create a record.');
        }
        
    }
}