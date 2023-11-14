({
    init: function(component, event, helper) {
    var contactAction = component.get("c.getContacts");
    contactAction.setCallback(this, function(contactResponse) {
        var contactState = contactResponse.getState();
        if (contactState === "SUCCESS") {
                var contacts = contactResponse.getReturnValue();
             contacts.forEach(function(contact) {
                    if (contact.Account) {
                        contact.AccountName = contact.Account.Name;
                    } else {
                        contact.AccountName = "";
                    }
                });
                            component.set("v.contacts", contacts);
                        component.set("v.editedContacts", contacts);


            component.set("v.columns", [
                { label: "First Name", fieldName: "FirstName", type: "text", editable: true },
                { label: "Last Name", fieldName: "LastName", type: "text", editable: true },
                { label: "Email", fieldName: "Email", type: "email", editable: true },
                { label: "Phone", fieldName: "Phone", type: "phone", editable: true },
                { label: "Account Name", fieldName: "AccountName", type: "text", editable: true }
            ]);
        }
    });

    var accountAction = component.get("c.getAvailableAccounts");
    accountAction.setCallback(this, function(accountResponse) {
        var accountState = accountResponse.getState();
        if (accountState === "SUCCESS") {
            component.set("v.availableAccounts", accountResponse.getReturnValue());
        }
    });

    $A.enqueueAction(contactAction);
    $A.enqueueAction(accountAction);
},

   

    showNewContactForm: function(component, event, helper) {
        component.set("v.showcontact", true);
    },

    createContact: function(component, event, helper) {
        var fname = component.find("fname").get("v.value");
        var lname = component.find("lname").get("v.value");
        var email = component.find("email").get("v.value");
        var phone = component.find("phone").get("v.value");
    var selectedAccountId = component.get("v.selectedAccountId");

        helper
            .createNewContact(component, fname, lname, email, phone,selectedAccountId)
            .then(function(newContact) {
                console.log("success")
            })
            .catch(function(error) {
                console.log("error")
            });
    },

    handleSave: function(component, event, helper) {
        
        var draftValues = event.getParam("draftValues");

        helper
            .updateContacts(component, draftValues)
            .then(function() {
                console.log("success")
            })
            .catch(function(error) {
                console.log("error")
            });
    },

    deleteContact: function(component, event, helper) {
    var selectedRows = component.find("contactDataTable").getSelectedRows();
    var contactIds = selectedRows.map(function(row) {
        return row.Id;
    });

    var confirmed = confirm("Are you sure you want to delete these contacts?");
    if (confirmed) {
        helper
            .deleteContacts(component, contactIds)
            .then(function() {
                console.log("success");
            })
            .catch(function(error) {
                console.log("error");
            });
    }
    }
        

});