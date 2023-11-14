@isTest
public class TestWrapperExample {
    @isTest
    static void testWrapperExample() {
        List<Account> testAccounts = new List<Account>();
        for (Integer i = 0; i < 10; i++) {
            testAccounts.add(new Account(Name = 'Test Account ' + i, BillingCity = 'Test City ' + i, Phone = '123456789' + i));
        }
        insert testAccounts;
        
        WrapperExample example = new WrapperExample();
        
        System.assertEquals(10, example.wrapaccountList.size());
        
        for (WrapperExample.wrapaccount wrapAcc : example.wrapaccountList) {
            wrapAcc.isSelected = true;
        }
        
        example.selectAccount();
        
        System.assertEquals(10, example.selectedAccounts.size());
    }
}