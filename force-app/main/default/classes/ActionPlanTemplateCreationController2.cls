public with sharing class ActionPlanTemplateCreationController2{
	
	private Double					taskIndex				{ get; set; }
	//public ActionPlanTemplatesService		actionPlanTemplatesService		{ get; set; }
	public ActionPlanTemplate__c 	actionPlanTemplate		{ get; set; }
	public String           		actionPlanTemplateId	{ get; set; }
	public Boolean					addedTask				{ get; set; }
    private List<ActionPlanTemplateTask__c> 		aptTasks;
	public Boolean					displayReminder			{ get; set; }

    public Map<String, ActionPlanTemplateTask__c> 	taskMap 				{ get; set; }
    public Integer                  		taskLimit;
    public String                   		errorMsg;
	
	/**
     * Constructor
     * If we can obtain the Id from the page parameters then we search for that template and set the variable for that template.
     * If we can't obtain the Id from the page parameters then we create a new template and obtain from the controller.
     * Then we need to check if we are cloning the template, in that case clone the template without Id.
     */
    public ActionPlanTemplateCreationController2( ApexPages.StandardController stdController ){

    	this.taskMap			= new Map<String, ActionPlanTemplateTask__c>();
    	this.errorMsg			= null;
        this.taskLimit  		= 75;

        this.taskIndex = 0;
        this.addedTask = false;

        aptTasks = new List<ActionPlanTemplateTask__c>();
        
        if( System.currentPageReference().getParameters().get( 'id' ) != null ){
        	
			this.actionPlanTemplateId 	= System.currentPageReference().getParameters().get( 'id' );
			this.actionPlanTemplate		= ActionPlanTemplatesService.getAPT(actionPlanTemplateId);
            loadTaskWrapper();

			this.taskIndex = this.calculateTaskIndexValue();
		}
		else{
			this.actionPlanTemplate = ( ActionPlanTemplate__c ) stdController.getRecord();
		}
		
       	if( System.currentPageReference().getParameters().get( 'clone' ) == '1' ){
       		ActionPlanTemplate__c apC = actionPlanTemplate.clone( false );
            this.actionPlanTemplate.clear();
            this.actionPlanTemplate = apC;
       	}
       	
        //this.actionPlanTemplates = new ActionPlanTemplates( this.actionPlanTemplate );
        //this.actionPlanTemplatesService.taskIndexNext = this.taskIndex;
        this.displayReminder = ActionPlansUtilities.getDisplayReminderStatic();
         
    }

	/**
	 * Call method getTemplateTasks() inside the class ActionPlanTemplates
	 */
	private void loadTaskWrapper(){

		
		ApTTaskWrapper apTTaskWrapper;
    	List<ApTTaskWrapper> tasksList = new List<ApTTaskWrapper>();
    	
    	if( this.actionPlanTemplate != null ){
    		Integer i = 0;
//    		for( ActionPlanTemplateTask__c aptTaskTemplate : actionPlanTemplate.Action_Plan_Template__r){
  //  			ApTTaskWrapper = new ApTTaskWrapper( aptTaskTemplate, i );
    //			tasksList.add( ApTTaskWrapper );
    //			i++;
    //		}
    	}
	}

	/**
	 * Call method saveTemplate() inside the class ActionPlanTemplates
	 * @return PageReference
	 */
	public PageReference saveTemplate(){
		return null; // actionPlanTemplatesService.saveTemplate();
	} 
	
	/**
	 * Call method cancelTemplate() inside the class ActionPlanTemplates
	 * @return PageReference
	 */
	public PageReference cancelTemplate(){
		return null; // actionPlanTemplatesService.cancelTemplate();
	}
	
	/**
	 * Call method addTemplateTask() inside the class ActionPlanTemplates
	 */
	public void addTemplateTask(){
		
		this.taskIndex++;
//		this.actionPlanTemplatesService.taskIndexOrder = this.taskIndex;
//		this.addedTask = actionPlanTemplatesService.addTemplateTask();
    	Boolean hasNoErrors = false;
    	
        if( ApexPages.currentPage().getParameters().get( 'add' ) == '1' ){
        	
            //in casethe task limit is reach set a message error to display
            if( this.aptTasks.size() >= this.taskLimit ){
                this.errorMsg = Label.ap_Errors_TaskLimitError;
            } 
            else{
                ActionPlanTemplateTask__c t = new ActionPlanTemplateTask__c();
                t.Reminder__c 	= false;
                t.taskIndex__c 	= this.taskIndex;
                
                // validate user, priority, subject and days before adding another
                hasNoErrors = true;
                for( ActionPlanTemplateTask__c apt : aptTasks ){
                	hasNoErrors = ( apt.Priority__c != null && apt.Subject__c != null );
                	if( apt.DaysFromStart__c < 1 ) {
	                	apt.DaysFromStart__c = 1;
	                }
                }

                //add to list of tasks
                if( hasNoErrors ){
                    this.aptTasks.add( t );
                    hasNoErrors = true;
                }
                else{
                	hasNoErrors = false;
                }
            }
        }
        
        //return hasNoErrors;      
	}
	
	/**
	 * Call method removeTemplateTask() inside the class ActionPlanTemplates
	 */
	public void removeTemplateTask(){
//		addedTask = !actionPlanTemplatesService.removeTemplateTask();
	}
	
	/**
	 * Call method getTemplateTasks() inside the class ActionPlanTemplates
	 */
	public List<ApTTaskWrapper> getTemplateTasks(){

		
		ApTTaskWrapper apTTaskWrapper;
    	List<ApTTaskWrapper> tasksList = new List<ApTTaskWrapper>();
/*    	
    	if( this.actionPlanTemplates != null ){
    		Integer i = 0;
    		for( ActionPlanTemplateTask__c aptTaskTemplate : this.actionPlanTemplates.getTemplateTasks() ){
    			ApTTaskWrapper = new ApTTaskWrapper( aptTaskTemplate, i );
    			tasksList.add( ApTTaskWrapper );
    			i++;
    		}
    		if( this.addedTask ){
    			tasksList.get( i - 1 ).isLast = true;	
    		}	
    	}
  */  	
    	return tasksList;
	}
	
	/**
	 * Call method getTemplateTaskSize() inside the class ActionPlanTemplates
	 */
	public Integer getTemplateTaskSize(){
        return aptTasks.size();
	}
	
	/**
	 * Call method getTemplateSubjectItems() inside the class ActionPlanTemplates
	 */
	public List<SelectOption> getTemplateSubjectItems(){
	    return null; //actionPlanTemplatesService.getTemplateSubjectItems();
	}
	
	/**
    * Checks if Action Plan Tasks has cycling dependency.
    * @return PageReference
    */
    public PageReference checkCycleDependent(){
    	/*
    	if( this.actionPlanTemplatesSer.checkCycleDependent() ){
    		return null;
    	}
    	else{
    		return this.saveTemplate();
    	} */
        return null;
    }
    
    /**
    * Getter method to return the error message from
    * action plans utilities
    * @return actionPlanTemplatesService.errorMsg
    */
    public String getErrorMsg(){
    	//return actionPlanTemplatesService.errorMsg;
        return null;
    }
    
    /**
    * Calculates the highest task index value
    * @return maxIndex
    */
    public Double calculateTaskIndexValue(){
    	
    	List<ActionPlanTemplateTask__c> aptTasks = [ select id, taskIndex__c from ActionPlanTemplateTask__c 
    											where Action_Plan_Template__c =: this.actionPlanTemplateId ];
    	
    	Double maxIndex = 0;
    	for( ActionPlanTemplateTask__c tsk : aptTasks ){
    		if( tsk.taskIndex__c > maxIndex ){
    			maxIndex = tsk.taskIndex__c;
    		}
    	}
    	
    	return maxIndex;
    }
    
    /**
    * Inner Wrapper Class for Action Plan Template Tasks
    * @author Matias Menafra
    * @createddate 08/08/2010
    */
    public class ApTTaskWrapper{
    	
    	public ActionPlanTemplateTask__c task 	{ get; set; }
		public 	Integer 	position 	{ get; set; }
    	public 	Boolean 	isLast 		{ get; set; }
    	
    	public ApTTaskWrapper( ActionPlanTemplateTask__c apTask, Integer pos ){
    		task 		= apTask;
    		position 	= pos;
    		isLast 		= false;
    	}
    }
}