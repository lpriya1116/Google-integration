({
	show : function(component, event, helper) {
       
        var empName=component.get("v.empName");
        var salary = component.get("v.salary");
         component.set("v.empName","priya");
        component.set("v.salary",1000);
		
	},
    cancel : function(component, event, helper) {
        component.set("v.empName","");
        component.set("v.salary",0);
        
    }

})