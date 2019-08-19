public interface IActionPlanTemplateTasksSelector extends fflib_ISObjectSelector {
	
	List<ActionPlanTemplate__c> selectById(Set<ID> idSet);

	
}
