public class Mapexample {  
    public static void Maptest() { 
        List<String>liststud = new List<String>();
        Map < String, String > studDept = new Map < String, String > ();    
        studDept.put('D01', 'CSE');  
        system.debug(studDept);   
        studDept.put('D02', 'CIVIL');  
        studDept.put('D03', 'MECH');  
        studDept.put('D04', 'EEE');  
        system.debug('get(D01) - Department is: ' + studDept.get('D01'));  
        system.debug('Department keyset() are : ' + studDept.keyset());   
        system.debug('Department values() are : ' + studDept.values());  
                liststud.addall(studDept.values());
        system.debug('List : ' + liststud);  
        Set<String>studDept1 =new Set<String>();
        studDept1=studDept.Keyset();
        system.debug('studDept1 : ' + studDept1);  
        Boolean t =studDept.containsKey('D06');
        System.debug('t='+t);
        Integer s = studDept.size();  
        system.debug('size() - Department Map Size : ' + s);   
        Map < String, String > studDeptc = studDept.clone();  
        system.debug('clone() - Department values() are : ' + studDeptc.values());   
        studDeptc.clear();  
        system.debug('clear() - Department values() are : ' + studDeptc.values());  
    }  
}