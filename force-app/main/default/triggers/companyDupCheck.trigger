trigger companyDupCheck on Company__c (before insert) {
       List<Company__c> com = [Select id, Name from Company__c]; 
    Map<string,Company__c> comMap = new  Map<string,Company__c>();
    
    for(Company__c ac : com){
        comMap.put(ac.Name, ac);
    }
    
    for(Company__c acc: Trigger.New){
        if(comMap.containsKey(acc.Name)){
            acc.addError('Duplicate Record - There is a company with name already exist.'); 
        }
        
    } 
}