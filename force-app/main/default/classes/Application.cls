public class Application 
{
/*
	// Configure and create the UnitOfWorkFactory for this Application
	public static final fflib_Application.UnitOfWorkFactory UnitOfWork = 
		new fflib_Application.UnitOfWorkFactory(
				new List<SObjectType> { 
					Invoice__c.SObjectType,
					InvoiceLine__c.SObjectType,
					Opportunity.SObjectType,
					Product2.SObjectType,
					PricebookEntry.SObjectType,
					OpportunityLineItem.SObjectType,
					WorkOrder__c.SObjectType,
					DeveloperWorkItem__c.SObjectType,
					TrainingWorkItem__c.SObjectType,
					DesignWorkItem__c.SObjectType });	
*/

	// Configure and create the ServiceFactory for this Application
	public static final fflib_Application.ServiceFactory Service = 
		new fflib_Application.ServiceFactory( 
			new Map<Type, Type> {
					IOpportunitiesService.class => OpportunitiesServiceImpl.class}
					);

	// Configure and create the SelectorFactory for this Application
	public static final fflib_Application.SelectorFactory Selector = 
		new fflib_Application.SelectorFactory(
			new Map<SObjectType, Type> {
                    ActionPlanTemplate__c.SObjectType => ActionPlanTemplatesSelector.Class
});
/*
	// Configure and create the DomainFactory for this Application
	public static final fflib_Application.DomainFactory Domain = 
		new fflib_Application.DomainFactory(
			Application.Selector,
			new Map<SObjectType, Type> {
					Opportunity.SObjectType => Opportunities.Constructor.class,
					OpportunityLineItem.SObjectType => OpportunityLineItems.Constructor.class,
					Account.SObjectType => Accounts.Constructor.class,
					DeveloperWorkItem__c.SObjectType => DeveloperWorkItems.class });
*/

}