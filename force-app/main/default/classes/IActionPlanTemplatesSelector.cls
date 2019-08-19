public interface IActionPlanTemplatesSelector extends fflib_ISObjectSelector {
	
	List<ActionPlanTemplate__c> selectById(Set<ID> idSet);
	List<ActionPlanTemplate__c> selectAll();
	List<ActionPlanTemplate__c> selectByIdWithTasks();
	
}
