public with sharing class ActionPlanTemplatesService {

 	
    public ActionPlanTemplatesDomain	actionPlanTemplates		{ get; set; }
    

    public ActionPlanTemplatesService() {

    }

    public static void saveAPT(Set<ID> aptIds){


    }

    public static ActionPlanTemplate__c getAPT(ID aptId){
        set<id> ids = new set<id>();
        ids.add(aptId);
        return ActionPlanTemplatesSelector.newInstance().selectByIdWithTasks(ids)[0];

    }


    public integer getTemplateTaskSize(){
        ActionPlanTemplate__c apt = (ActionPlanTemplate__c) actionPlanTemplates.records[0];
        
        integer x;
        if (apt.ActionPlanTemplateTasks__r.isEmpty()) {x = 0;}
        else {x = apt.ActionPlanTemplateTasks__r.size();}
            
       return x;
    }

    public string ErrorMsg(){
        return actionPlanTemplates.errorMsg;
    }

}
