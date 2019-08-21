public interface IActionPlanTemplateTasksSelector extends fflib_ISObjectSelector {
	
	List<ActionPlanTemplateTask__c> selectById(Set<ID> idSet);

	
}
