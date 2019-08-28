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

        /** 
     * Performas validation on insert of new aptt
     **/
	public override void onValidate() {	    
        //CAN'T BE dependent on self or self in heirarchy
        //

        //loop through all the records

		for(ActionPlanTemplateTask__c r : (List<ActionPlanTemplateTask__c>) Records) {
	    
           // if Due Date Relationship if field,
            if (r.DueDateRelation__c.contains('Field')) {
                //then related date field required
                If (r.RelatedDateField__c == null)  
                    r.RelatedDateField__c.addError('Related Date field required');
            } else {
                //otherwise date field must be blank
                If (r.RelatedDateField__c != null) 
                    r.RelatedDateField__c.addError('Related Date must be blank');
            }

            //if after plan start, then
            //no dependency allow
            if ((r.DueDateRelation__c == 'After Plan Start') && (r.TemplateTaskDependency__c != null))
                r.TemplateTaskDependency__c.addError('No Dependency allowed for "After Plan Start"');

            //if after dependent task
            if ((r.DueDateRelation__c == 'After Dependent Task') && (r.TemplateTaskDependency__c == null))
            //then dependnt task required
                r.TemplateTaskDependency__c.addError('Depentent Task required');
        }

    }

        /** 
     * Performas validation on update of existing  aptt
     **/
	public override void onValidate(Map<Id,SObject> existingRecords) {	    
        this.onValidate();
    }


	public class Constructor implements fflib_SObjectDomain.IConstructable {
		public fflib_SObjectDomain construct(List<SObject> sObjectList) {
			return new ActionPlanTemplateTasks(sObjectList);
		}
	}	
}
