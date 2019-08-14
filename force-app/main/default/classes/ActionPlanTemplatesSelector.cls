/**
 * This is a basic selector for APT for this app, note how it implements 
 **/
public class ActionPlanTemplatesSelector extends fflib_SObjectSelector
    implements IActionPlanTemplatesSelector {
    
	public static IActionPlanTemplatesSelector newInstance()
	{
		return (IActionPlanTemplatesSelector) Application.Selector.newInstance(ActionPlanTemplate__c.SObjectType);
	}
	
	public List<Schema.SObjectField> getSObjectFieldList()
	{
		return new List<Schema.SObjectField> {
			ActionPlanTemplate__c.Id,
			ActionPlanTemplate__c.Description__c
		};
	}

	public Schema.SObjectType getSObjectType()
	{
		return ActionPlanTemplate__c.sObjectType;
	}

	public List<ActionPlanTemplate__c> selectById(Set<ID> idSet)
	{
		return (List<ActionPlanTemplate__c>) selectSObjectsById(idSet);
	}

}
