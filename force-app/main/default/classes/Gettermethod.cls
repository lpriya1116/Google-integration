public class Gettermethod {
    public list<Account>accounts = new list<Account>();
public list <Account>accdetails = new list <Account>();
    public void addme(){
        accounts = [select id,name from Account limit 5];
        system.debug('accounts' +accounts);
        Account acc = new Account();
        for(Account acc1 : accounts ){
        acc.id = acc1.id;
        acc.name = acc1.name;
        accdetails.add(acc);
        }
        system.debug('accdetails' +accdetails);
    }
}