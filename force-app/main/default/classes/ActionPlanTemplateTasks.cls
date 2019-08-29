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

            //if after dependent task then dependnt task required
            if ((r.DueDateRelation__c == 'After Dependent Task') && (r.TemplateTaskDependency__c == null))
                r.TemplateTaskDependency__c.addError('Depentent Task required');

            checkCyclicDependency();
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


    /**
    * Checks if Action Plans Tasks has cycling dependency.
    * @return exists
    */

    public void checkCyclicalDependency(){
        //get id set of records
        Set<ID> tIds = new Set<ID>();
        for(SObject r : Records){
            tIds.add(r.Id);
        }

        //get the aptt with tasks for any task for any record being updated
        Map<ID, ActionPlanTemplate__c> apts = new Map<Id, ActionPlanTemplate__c>(new ActionPlanTemplatesSelector().selectByIdWithTasks(tIds));

        //loop thorugh records checking for dependencies
        for( ActionPlanTemplateTask__c t : (List<ActionPlanTemplateTask__c>)records ){
            if (t.TemplateTaskDependency__c != null) {

                //make sure not dependent on self  
                //*** no longer neeeded
                //SF produces this error: Hierarchy Constraint Violation  You cannot set a hierarchy field Task Dependency to point to itself or a child record. Either edit one of the child records to not refer to this record, or do not set the field on this record. 
                /*
                if (t.TemplateTaskDependency__c == t.id) 
                    t.TemplateTaskDependency__c.addError(Label.ap_ItselfDependencyError); */

                //get all the tasks associated with this PlanTemplate
                ActionPlanTemplate__c apt = apts.get(t.id);
                Map<Id, ActionPlanTemplateTask__c> aptts = new Map<Id, ActionPlanTemplateTask__c>(apt.ActionPlanTemplateTasks__r);
                

                //make sure the current task is not dependent 
                //on itself somwhere in in the hierachy
//                Boolean hasCyclicalDependency = false;

                ActionPlanTemplateTask__c tStep = t;
                while (tStep.TemplateTaskDependency__c != null) {
                    //check that the next step in the depency
                    //is not is the same as the current record
                    if (tstep.TemplateTaskDependency__c == t.Id) {
                        t.TemplateTaskDependency__c.addError(Label.ap_Errors_RemoveCyclicDependency);
  //                      hasCyclicalDependency = true;
                    }
                    
                    //get the next dependent task 
                    tStep = aptts.get(tstep.TemplateTaskDependency__c);
                }

                

                

            }
        }


    }

    /**
    * Checks if Action Plans Tasks has cycling dependency.
    * @return exists
    *
    public Boolean checkCycleDependent(){

    	this.errorMsg 	= '';
    	Boolean exists 	= false;
    	Integer index 	= 0;
        
        for( ActionPlanTemplateTask__c t : this.aptTasks ){
            if( t.Dependent__c != 'None' && t.Dependent__c != null ){
                Integer tempIndex   	= Integer.valueOf( t.Dependent__c );
                ActionPlanTemplateTask__c link = this.aptTasks[tempIndex];
                
                //task can not depend on themselves
                if(tempIndex == index){
                	this.errorMsg = Label.ap_ItselfDependencyError;	
                	return true;
                }
                
                if( this.dependantCycle( t, link, index ) ){
                	this.errorMsg = Label.ap_Errors_RemoveCyclicDependency;	
                	return true;
                }
            }
            index++;
        }
        return exists;
    }
	
	/**
    * 
    * @param originTask
    * @param destinyTask
    * @param index
    * @return Boolean
    *
	private Boolean dependantCycle( ActionPlanTemplateTask__c originTask, ActionPlanTemplateTask__c destinyTask, Integer index ){
		
        Boolean hasDependency = false;
        Set<Integer> visitedTasks = new Set<Integer>();
        
        while( !hasDependency ){
        	
        	if (destinyTask.Dependent__c != 'None'){
        		if (visitedTasks.contains(Integer.valueOf( destinyTask.Dependent__c ))){
        			hasDependency = true;
	        		break;
        		}else{
        			visitedTasks.add(Integer.valueOf( destinyTask.Dependent__c ));
        		}
        	}
        	
			if( destinyTask.Dependent__c != 'None' && destinyTask.Dependent__c != null  ){
				Integer tempIndexDestiny 	= Integer.valueOf( destinyTask.Dependent__c );
				ActionPlanTemplateTask__c link 		= this.aptTasks[ tempIndexDestiny ];
	
				if( link.Dependent__c != 'None' ){
					if( Integer.valueOf( link.Dependent__c ) == index ){
						hasDependency = true;
    					break;
    				}
    				else{
    					//get Next task in dependency chain
    					Integer tempIndex 	= Integer.valueOf( destinyTask.Dependent__c );
    					destinyTask 		= this.aptTasks[ tempIndex ];
    				}	
				}
				else{
					break;
				}
 			}
 			else{
 				break;
			}
    	}

    	return hasDependency;
	} 
*/
    
}
