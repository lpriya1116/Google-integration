trigger Employee_trig1 on Employee__c (after insert) {
    list<Employee__c>employees = Trigger.new;
        list<Department__c> dept = new list<Department__c>();
    for(Employee__c emp : employees){
        Department__c d = new Department__c();
        d.name=emp.name;
        d.Dept_name__c=emp.Department__c;
        dept.add(d);
            }
    
        

}