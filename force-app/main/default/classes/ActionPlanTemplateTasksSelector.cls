/**
 * This is a basic selector for APT for this app, note how it implements 
 **/
public class ActionPlanTemplateTasksSelector 
    extends fflib_SObjectSelector
    implements IActionPlanTemplateTasksSelector {
    
	public static IActionPlanTemplateTasksSelector newInstance()
	{
		return (IActionPlanTemplateTasksSelector) Application.Selector.newInstance(ActionPlanTemplateTask__c.SObjectType);
	}
	
	public List<Schema.SObjectField> getSObjectFieldList()
	{
		return new List<Schema.SObjectField> {
			ActionPlanTemplateTask__c.Id,
			ActionPlanTemplateTask__c.Action_Plan_Template__c
			
		};
	}

	public Schema.SObjectType getSObjectType()
	{
		return ActionPlanTemplateTask__c.sObjectType;
	}

	public List<ActionPlanTemplateTask__c> selectById(Set<ID> idSet)
	{
		return (List<ActionPlanTemplateTask__c>) selectSObjectsById(idSet);
	}

}
