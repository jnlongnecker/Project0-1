trigger Order_Trigger on Order (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    switch on trigger.operationType {
        when BEFORE_INSERT { // Fires on Upsert

        }
        when BEFORE_UPDATE { // Fires on Upsert and Merge

        }
        when BEFORE_DELETE { // Fires on Merge
           
        }
        when AFTER_INSERT { // Fires on Upsert
        
        }
        when AFTER_UPDATE { // Fires on Upsert and Merge
            triggerHandler.orderEmail(trigger.new, trigger.oldMap);
        }
        when AFTER_DELETE { // Fires on Merge
            
        }
        when AFTER_UNDELETE {

        }
    }
}