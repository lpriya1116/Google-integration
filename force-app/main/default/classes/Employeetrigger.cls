public class Employeetrigger {

    public static void sendEmailNotification(list <Employee__c> emplist)  {
        list<Messaging.Email> emailList = new list <Messaging.Email>();
        for(Employee__c emp: emplist){
            if (emp.Email__c != null){
           Messaging.SingleEmailMessage emailMsg = new Messaging.SingleEmailMessage();
            String[] toAddress = new String[]{emp.Email__c};
            emailmsg.setToAddresses(toAddress);
            String emailsub ='Welcome' +emp.name;
             emailmsg.setsubject(emailsub);
            String disname ='Hello';
            emailmsg.setSenderDisplayName(disname);
             String content = 'Hi' +emp.name   + '<br/> <br/>' +
                 'Welcome to salesforce <br/>' +
                 'Thankyou';
            emailmsg.setHtmlBody(content);
                emaillist.add(emailmsg);
            
            
        }
    }
          Messaging.sendEmail(emailList);
    
}
    
}