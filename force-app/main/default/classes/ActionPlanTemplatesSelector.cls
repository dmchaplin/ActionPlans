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
			ActionPlanTemplate__c.Description__c,
			ActionPlanTemplate__c.Name,
			ActionPlanTemplate__c.ImportId__c,
			ActionPlanTemplate__c.SkipDay__c,
			ActionPlanTemplate__c.SkipDefaultCompanyHolidays__c,
			ActionPlanTemplate__c.SkipWeekends__c,
			ActionPlanTemplate__c.TaskRecordTypeID__c
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

	public List<ActionPlanTemplate__c> selectByIdWithTasks(Set<ID> idSet)
	{
		fflib_QueryFactory actionPlanTemplatesQueryFactory = newQueryFactory();

		//add the related tasks
		fflib_QueryFactory actionPlanTemplateTasksQueryFactory = 
			new ActionPlanTemplateTasksSelector()
			.addQueryFactorySubselect(ActionPlanTemplatesQueryFactory);
		
		return (List<ActionPlanTemplate__c>) Database.query(
			actionPlanTemplatesQueryFactory.toSOQL()
		);

	}

	public List<ActionPlanTemplate__c> selectAll() {
		return (List<ActionPlanTemplate__c>) Database.query (
			newQueryFactory()
				.setLimit(1000)
				.addOrdering('Name', fflib_QueryFactory.SortOrder.ASCENDING )
				.toSOQL()
			);
	}

}
