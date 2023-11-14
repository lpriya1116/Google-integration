trigger Employee_trigger on Employee__c (after insert) {
    Employeetrigger.sendEmailNotification(Trigger.new);

}