public class Employeewrap1 {
    public Account acc;
    public List<Account>accounts;
    public Employeewrap1(){
        acc = new Account();
        accounts = new List<Account>();
    }
    public void addrow(){
        accounts.add(acc);
        acc = new account();
    }
    public void clear(){
        accounts.clear();
    }
    
}