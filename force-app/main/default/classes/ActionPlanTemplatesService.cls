public with sharing class ActionPlanTemplatesService {
    public ActionPlanTemplatesService() {

    }

    public static void saveAPT(Set<ID> aptIds){


    }

    public static ActionPlanTemplate__c getAPT(ID aptId){
        set<id> ids = new set<id>();
        ids.add(aptId);
        return ActionPlanTemplatesSelector.newInstance().selectById(ids)[0];

    }
}
