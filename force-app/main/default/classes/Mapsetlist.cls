public class Mapsetlist {
         Map <Id,Employee__c> firstMap = new Map <Id,Employee__c>();
         Map <Id,Employee__c> secondMap = new Map <Id,Employee__c>();
         Map<Id , list<Employee__c>> mainMap = new Map<Id , list<Employee__c>>();
         Set<String> setOfIdsInFirstMap = new Set<String>();
    
         public void Mapsetlistmethod(){
         for(String key : firstMap.keyset() ){
         list<Employee__c> lstEmployee = new list<Employee__c>();
         if(secondMap.containsKey(key)){
         lstEmployee.add(secondMap.get(key));
}
         setOfIdsInFirstMap.add(key);
         lstEmployee.add(firstMap.get(key));

//mainMap.put(key);
}

       for(String key : secondMap.keyset()){

       if(!setOfIdsInFirstMap.contains(key)){
       mainMap.put(key , new list<Employee__c>{secondMap.get(key)});
}
}
    }
//system.debug(mainMap + ' @@@@ Main Map @@@@ ');

}