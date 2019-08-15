public with sharing class ActionPlanTemplateService {
    public ActionPlanTemplateService() {

    }

    global static void saveAPT(Set<ID> aptIds){


    }

    global static ActionPlanTemplate__c getAPT(ID aptId){
        set<id> ids = new set<id>();
        ids.add(aptId);
        return ActionPlanTemplatesSelector.newInstance().selectById(ids);

    }
}
