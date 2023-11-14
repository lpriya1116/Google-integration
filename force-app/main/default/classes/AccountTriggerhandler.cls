public class AccountTriggerhandler {
    
    public static void beforeinsert(list<Account>newlist) {
        for(Account acc: newlist){
        if(acc.Industry == 'Media'){
            acc.Rating = 'hot';
             }
    }
    }
    public static void afterinsert(list<Account>newlist){
        list<Opportunity>oppins =  new list<opportunity>();
        for(Account acc: newlist){
            opportunity op = new opportunity();
            op.name = acc.name;
            op.AccountId = acc.id;
            op.StageName = 'prospecting';
            op.CloseDate = system.today();
            oppins.add(op);
        }
        if(!oppins.isEmpty()){
            insert oppins;
        }
    }
    
    public static void beforeupdate(list<Account>newlist,map<id,Account>oldmap){
        for(Account acc : newlist){
            if(oldmap!= null && acc.phone != oldmap.get(acc.id).phone){
                acc.Description = 'phone is updated';
                
            }
        }
        
    }
}