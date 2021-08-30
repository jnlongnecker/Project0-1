public class Project0Handlers {
    
    //Order Type:
    //Purchased: 0125e000000Rk9RAAS
    //Supplied: 0125e000000Rk9WAAS
    //Account Type: 
    //Customer: 0125e000000RkPUAA0
    //Supplier: 0125e000000RkPPAA0
    
    //Check to see if the order type with account type
        public static Boolean isMatching(Account currAccountId, Order currOrderId){
            Id customerAccountID = Schema.SObjectType.Account.getRecordTypeInfosbyName().get('Custumer').getRecordTypeId();
            Id supplierAccountID = Schema.SObjectType.Account.getRecordTypeInfosbyName().get('Business').getRecordTypeId();
            Id purchaseOrderId = Schema.SObjectType.Order.getRecordTypeInfosbyName()
                .get('Purchase Order').getRecordTypeId();
            Id supplyOrderId = Schema.SObjectType.Order.getRecordTypeInfosbyName()
                .get('Supply Order').getRecordTypeId();
            Integer n = 0; 
            if (currOrderId.RecordTypeId == purchaseOrderId){
                if (currAccountId.recordTypeId != customerAccountId){
                   n++;
                }
            }
            else if (currOrderId.recordTypeId == supplyOrderId){
                if (currAccountId.recordTypeId != supplierAccountId){
                    n++; 
                }
                    
            }
            return n == 1;
        }
        
        private static Map<Order, Account> AccountRTId(List<Order> newOrder){
            Set<Id> AccountId = new Set<Id>();
            for (Order currOrder : newOrder){
                AccountID.add(currOrder.Accountid);
            }
    
            List<Account> account = [SELECT RecordTypeId, id FROM Account WHERE id IN: Accountid];
            
            Map<Order, Account> matchingAccount = new Map<Order, Account>();
            for (Order currOrder : newOrder){
                for (Account currAccount: account){
                    if (currOrder.AccountId == currAccount.id){
                        matchingAccount.put(currOrder, currAccount);
                    }
                }
            }
            for (Order currOrder : newOrder){
                System.debug('Order: ' + currOrder);
                System.debug('Account ' + matchingAccount.get(currOrder));
            }
            Return matchingAccount;
        }
            //Checks if the order type matches with the account type; if not, throws an error message. 
        public static void Match(List<Order> matchingOrder){
            Map<Order, Account> accountinfo = accountRTId(matchingOrder);
            List<Account> matchingAccount= new List<Account>();
            List<Order> confirmedOrder = new List<Order>();
            for (Order currOrder: matchingOrder){
                matchingAccount.add(accountinfo.get(currOrder));
            }
            for (Integer i = 0; i < matchingOrder.Size(); i++){
                if (!isMatching(matchingAccount[i], matchingOrder[i])){
                    matchingOrder[i].addError('Order Type and Account Type must Match.');
                }
                else{
                    confirmedOrder.add(matchingOrder[i]);
                }
            }
        }
        
    
        //--------------- After Trigger -----------------
        
        //Creates new Supply based on Order
        private static Supply__c CreateNewSupply(Order order) {
    
            Supply__c newSupply = new MyFirst_Package__supply__c();
            newsupply.MyFirst_Package__Order__c = order.id;
            newSupply.MyFirst_Package__Inventory__c = Id.valueOf('a005e0000063VUHAA2');
                
            return newSupply;
        }
        @TestVisible private static Boolean supplyOrder(Order currOrder){
            return currorder.RecordTypeId == Id.valueOf('0125e000000Rk9RAAS');
        }
        //Goes through the order and create new related Inventory item
        public static void addSupply(List<Order> newOrder) {
            List <MyFirst_Package__Supply__c> newSupply = new List<MyFirst_Package__Supply__c>();
            for (order currOrder : newOrder) {
                if (!SupplyOrder(currOrder)){
                    continue;
                }
                else{
                    newSupply.add(CreateNewSupply(currOrder));
                }
            }
            Insert newSupply;
        }
            public static void rewardUpdate(List<Account> updatedAcc){
            System.debug(updatedAcc.Size());
            for (Account currAccount:updatedAcc){
                if (checkStatus(currAccount)){
                    currAccount.Reward_Points__c = 500;
                } 
            }
        }
        @testVisible private static Boolean checkStatus(Account currAccount){
            Boolean isReward = currAccount.Reward_Status__c == True;
            return isReward;
        }
    
    }