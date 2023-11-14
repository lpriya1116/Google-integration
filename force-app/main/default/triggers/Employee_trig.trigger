trigger Employee_trig on Employee__c (before insert) {
list<Employee__c> employees = Trigger.new;
    for(Employee__c emp:employees){
        emp.name = 'Test';
        emp.contact_number__c ='9865235623';
    }
    
}