({
    loadEmployees: function(component, event, helper) {
        var newEmployee = component.get("v.newEmployee");

        var action = component.get("c.createEmployee");
        action.setParams({ "employee": newEmployee });

  action.setCallback(this, function(response) {
        var state = response.getState();
    if (state === "SUCCESS") {
                component.set("v.newEmployee", { 'sobjectType': 'Employee__c' });
                helper.loadEmployees(component);
            } else {
                console.log("Error creating employee record");
            }
        });

        $A.enqueueAction(action);
    }
})