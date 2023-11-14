({
 createNewContact: function(component, fname, lname, email, phone, accountName) {
        var action = component.get("c.createContactWithAccount");
        action.setParams({
            "firstName": fname,
            "lastName": lname,
            "email": email,
            "phone": phone,
            "accountName": accountName 
        });

  action.setCallback(this, function(response) {
    var state = response.getState();
    if (state === "SUCCESS") {
      var newContact = response.getReturnValue();
      var contacts = component.get("v.contacts");
    contacts.push(newContact);
   component.set("v.contacts", contacts);
  component.set("v.showcontact", false);
          var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Success",
                    "message": "Contact created successfully",
                    "type": "success"
                });
                toastEvent.fire();
                resolve(newContact);
            } else {
                console.log("Error.");
                reject(response.getError());
            }
        });

        $A.enqueueAction(action);
    
},


    updateContacts: function(component, draftValues) {
            var action = component.get("c.updateContacts");
            action.setParams({
                "contacts": draftValues
            });

     action.setCallback(this, function(response) {
   var state = response.getState();
               if (state === "SUCCESS") {
                    console.log("Contacts updated successfully");
                     var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        "title": "Success",
                        "message": "Contacts edited successfully",
                        "type": "success"
                    });
                    toastEvent.fire();
                   $A.get('e.force:refreshView').fire();
        
                } else {
                    console.log("Error updating contacts");
                }
            });

            $A.enqueueAction(action);
        
    },

    deleteContacts: function(component, contactIds) {
    if (contactIds.length === 0) {
        console.log("No contacts");
        return;
    }

    var action = component.get("c.deleteContacts");
    action.setParams({
        "contactIds": contactIds
    });

    action.setCallback(this, function(response) {
        var state = response.getState();
        if (state === "SUCCESS") {
            console.log("Successfully");

            var contacts = component.get("v.contacts");
            contacts = contacts.filter(function(contact) {
                return !contactIds.includes(contact.Id);
            });
            component.set("v.contacts", contacts);

            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "title": "Success",
                "message": "Contacts deleted successfully",
                "type": "success"
            });
            toastEvent.fire();
        } else {
            console.log("Error");

            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "title": "Error",
                "message": "Error deleting contacts",
                "type": "error"
            });
            toastEvent.fire();
        }
    });

    $A.enqueueAction(action);
}
})