@isTest
public class P0Test {
    /*public static void TP_isMatching() {
        Test.startTest();
        
        Account testAcc = TestHelper.InsertAccounts(1)[0];
        Order testOrder = TestHelper.InsertOrders(1, testAcc)[0];
        Boolean Result = Project0Handlers.isMatching(testAcc.recordTypeId, testOrder.recordTypeId); */
    
    //Testing Positive In Bulk
    @isTest
    public static void TS_Match(){
        Test.startTest();
        TestHelper.InsertAccounts(1);
        List<Account> someAccounts = [SELECT Ownerid, id, recordTypeid FROM Account];
        List <Order> someOrder = TestHelper.ReturnOrders(1, someAccounts);
        Integer numValid = 0;
        
        
        //Project0Handlers.Match(someOrder);
        Insert someOrder;
        List<Order> confirmed = [SELECT id FROM Order];
        for (Order currOrder : confirmed){
            numValid++;
        }
        System.assertEquals(1, numValid);
        
        Test.stopTest();
    }

    @isTest
    public static void TP_Match(){
        Test.startTest();
        TestHelper.InsertAccounts(16);
        List<Account> someAccounts = [SELECT Ownerid, id, recordTypeid FROM Account];
        List <Order> someOrder = TestHelper.ReturnOrders(16, someAccounts);
        Integer numValid = 0;
        Insert someOrder;
        List<Order> confirmed = [SELECT id FROM Order];
        for (Order currOrder : confirmed){
            numValid++;
        }
        System.assertEquals(32, numValid);

        
        Test.stopTest();
    }
    
    //Testing Negative in Bulk 
    /*@isTest
    public static void TN_Match(){
        Test.startTest();
        
        TestHelper.InsertAccounts(16);
        List<Account> someAccounts = [SELECT Ownerid, id, RecordTypeId FROM Account];
        List <Order> someOrder = TestHelper.ReturnOrders(16, someAccounts);
        Integer numValid = 0;
        Project0Handlers.Match(someOrder);
        
        List<Order> confirmed = [SELECT id FROM Order];
        
        for (Order currOrder : someOrder){
                numValid++;
        }
        System.assertEquals(0, numValid);
        Test.stopTest();
    }*/



    @isTest
    public static void TP_CheckStatus(){
        Test.startTest();
        
        TestHelper.InsertAccounts(16);
        List<Account> someAccounts = [SELECT id, reward_status__c, reward_points__c FROM Account];
        Handler2.rewardUpdate(someAccounts);
        Integer numValid = 0;
        
        for (Account currAccount:someAccounts){
         if (currAccount.Reward_Points__c == 500){
                numValid++;
            }
        }
        
        
        System.assertEquals(16, numValid);
        
        Test.stopTest();

    }
    
    @isTest 
    public static void TN_CheckStatus(){
        Test.startTest();
        
        TestHelper.InsertAccounts(15);
        List<Account> someAccounts = [SELECT id, reward_status__c, reward_points__c FROM Account];
        Handler2.rewardUpdate(someAccounts);
        Integer numValid = 0;
        for (Account currAccount:someAccounts){
            if (currAccount.Reward_Points__c != 500){
                numValid++;
            }
        }
        System.assertEquals(0, numValid);
        
        Test.stopTest();
    }

    @isTest
    public static void TP_addSupply(){
        
        Test.startTest();
        
        TestHelper.InsertAccounts(16);
        List<Account> someAccount = [Select id, RecordTypeId FROM Account];
        TestHelper.InsertOrders(16, someAccount);
        List<Order> someOrders = [SELECT id, AccountId, RecordTypeId FROM Order];
        Project0Handlers.addSupply(someOrders);
        
        List<MyFirst_Package__supply__c> supplyList = [SELECT name FROM MyFirst_Package__supply__c];
        
        System.assertEquals(16, supplyList.size());
        Delete supplyList;
        Test.stopTest();
        
    }
    @isTest
        public static void TN_addSupply(){
        Test.startTest();
        
        TestHelper.InsertAccounts(17);
        List<Account> someAccount = [Select id, RecordTypeId FROM Account];
        TestHelper.InsertOrders(17, someAccount);
        List<Order> someOrders = [SELECT id, AccountId, RecordTypeId FROM Order];
        Project0Handlers.addSupply(someOrders);
        
        List<MyFirst_Package__supply__c> supplyList = [SELECT name FROM MyFirst_Package__supply__c];
        supplylist.size();

        System.assertEquals(0, supplylist.size());
        Test.stopTest();
    }
}