({
	invoke : function(component, event, helper) {
        var salary = component.get("v.salary");
        var exp = component.get("v.exp");
        var bonus = 0;
        if(exp>5){
            bonus = salary*0.30;
        }else{
            bonus = salary*0.20;
        }
		bonus = component.set("v.bonus",bonus);
	}
})