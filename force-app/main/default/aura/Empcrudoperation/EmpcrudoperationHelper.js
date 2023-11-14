({
    loadEmployees: function(component) {
        var action = component.get("c.getEmployees");

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var employees = response.getReturnValue();
                component.set("v.employees", employees);
            } else {
                console.log("Error loading employees");
            }
        });

        $A.enqueueAction(action);
    }
})