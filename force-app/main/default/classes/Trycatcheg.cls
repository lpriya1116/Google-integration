public class Trycatcheg {

    public static void TrycatchegMethod(){
        try {
            
            Employee__c NameToUpdate = [SELECT Name, contact_number__c FROM Employee__c Where Name='abc'];
            System.debug('Line of code after exception'+NameToUpdate);
        }catch (QueryException e) {
              System.debug('Query Exception hit'+e);
        }catch(DmlException e){
      	      System.debug('DmlException hit'+e);
        }catch (Exception e) {
              System.debug('Exception hit'+e);
        } 
    }
}