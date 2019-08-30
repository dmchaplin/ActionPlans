public with sharing class ActionPlanTemplates extends fflib_SObjectDomain 
 	implements IActionPlanTemplate{

    public String                   		errorMsg;

    /**
    * Constructor
    * @param List of actionPT
    */
    public ActionPlanTemplates(List<ActionPlanTemplate__c> sObjectList) {
        super(sobjectList);
        errorMsg = null;
    }

    public void saveTemplate() {

    }



}
