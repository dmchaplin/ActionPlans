public with sharing class ActionPlanTemplatesDomain extends fflib_SObjectDomain 
 	implements IActionPlanTemplate{

    public String                   		errorMsg;

    /**
    * Constructor
    * @param List of actionPT
    */
    public ActionPlanTemplatesDomain(List<ActionPlanTemplate__c> sObjectList) {
        super(sobjectList);
        errorMsg = null;
    }

    public void saveTemplate() {

    }



}
