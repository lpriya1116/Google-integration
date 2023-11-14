@isTest
public class TestEmployeedisplay {
        @testSetup static void setup() {
            Employeedisplay c = new Employeedisplay();
            c.ID = '101';
            c.Name = 'Arjun';
            c.Salary = '20000';
    }

@isTest
    public Static void testshowDetails(){
        Employeedisplay a = new Employeedisplay();
        a.showDetails();
        
        
   }
    @isTest
    public Static void testdeleteDetails(){
        Employeedisplay b = new Employeedisplay();
        b.deleteDetails();
    }
        
}