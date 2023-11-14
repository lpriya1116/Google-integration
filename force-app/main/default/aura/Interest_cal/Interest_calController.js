({
    add: function(component, event, helper) {
      var aval = component.find("aval").get("v.value");
     var bval = component.find("bval").get("v.value");
    var cval = parseInt(aval) + parseInt(bval); 
  component.find("cval").set("v.value", cval); 
    },
    multiply: function(component, event, helper) {
      var aval = component.find("aval").get("v.value");
    var bval = component.find("bval").get("v.value");
  var cval = parseInt(aval) * parseInt(bval); 
        component.find("cval").set("v.value", cval); 
 },
 reset: function(component, event, helper) {
    component.find("aval").set("v.value", 0);
   component.find("bval").set("v.value", 0);
 component.find("cval").set("v.value", 0); 
    }
})