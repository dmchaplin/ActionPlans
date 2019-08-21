public with sharing class ActionPlanTemplateTasks 
    extends fflib_SObjectDomain 
 	implements IActionPlanTemplate{

    /**
    * Constructor
    * @param List of actionPT
    */
    public ActionPlanTemplateTasks(List<ActionPlanTemplateTask__c> sObjectList) {
        super(sobjectList);
    }
}
