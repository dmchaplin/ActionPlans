public interface IActionPlanTemplatesSelector extends fflib_ISObjectSelector {
	List<ActionPlanTemplate__c> selectById(Set<ID> idSet);
}
