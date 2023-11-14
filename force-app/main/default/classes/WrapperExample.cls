public class WrapperExample {
    public list<wrapaccount> wrapaccountList { get; set; }
    public list<account> selectedAccounts{get;set;}    

      
      public WrapperExample (){
          wrapaccountList =new list<wrapaccount>();
          for(account a:[select id,name,billingcity,phone from account limit 10])
          {
           wrapaccountlist.add(new wrapaccount(a));
           }
          System.debug('wrapaccountList:' +wrapaccountList);
      }
      public void selectAccount(){
     selectedAccounts=new list<account>();
     
      for(wrapaccount obj:wrapaccountlist){
           if(obj.isSelected==true){
           selectedAccounts.add(obj.accn);
           }
            
         }
      }
         
   public class wrapaccount{
    
    public account accn{get;set;}
    public boolean isSelected{get;set;}
     
       
       public wrapaccount(Account a)
     {
     
         accn=a;
         isselected=false;
       }
  }
}