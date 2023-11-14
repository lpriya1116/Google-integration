trigger Account_Trig on Account (before insert,after insert,before update) {
    if(Trigger.isInsert){
        if(Trigger.isBefore){
    AccountTriggerhandler.beforeinsert(Trigger.new);
        }
        else if(Trigger.isAfter)
        {
        AccountTriggerhandler.afterinsert(Trigger.new);
        }
    }
    if(Trigger.isUpdate){
        if(Trigger.isBefore){
            AccountTriggerhandler.beforeupdate(Trigger.new,Trigger.oldmap);
            
        }
    }
}