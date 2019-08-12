/*
Action Plans v3
Force.com Labs
http://appexchange.salesforce.com/listingDetail?listingId=a0N30000003HcINEA0

Copyright (c) 2011, salesforce.com, Inc.
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, 
are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice, 
    this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright notice, 
    this list of conditions and the following disclaimer in the documentation 
    and/or other materials provided with the distribution.
    * Neither the name of the salesforce.com, Inc. nor the names of its contributors 
    may be used to endorse or promote products derived from this software 
    without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED 
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. 
IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, 
INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, 
BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, 
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF 
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE 
OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED 
OF THE POSSIBILITY OF SUCH DAMAGE.

*/
@isTest
private class ActionPlansTaskTriggerUtilitiesTest {

    /**
     test trigger without skipweekends 
      method for testing Task  After Update trigger
	     when updating task to status 'Completed'
    
    */    
    
    public static testMethod void testTrigger1() {
    	
    	ActionPlansTestUtilities ge = new ActionPlansTestUtilities();
    	ActionPlan__c ap 			= ge.createNewActionPlan( 'accounts', 0 );
    	
    	
    	List<Id> apTTaskIds 		= new List<Id>();
    	List<Task> apTask 			= new List<Task>();
    	List<ActionPlanTask__c> aptt = new List<ActionPlanTask__c>();
    	
		Test.startTest();
		   	for( Integer i = 0; i < 4; i++ ){
		   		ActionPlanTask__c at = new ActionPlanTask__c();
		   		at.Action_Plan__c 	 = ap.Id;
		   		at.DaysFromStart__c  = 2.0;
		   		at.User__c			 = ge.createTestUser().Id;
		   		if (i == 0){
		   			at.SendEmail__c		 = true;
		   		}else{
		   			at.SendEmail__c		 = false;
		   		}
		   		at.Subject__c		 = 'Test '+ i;
		   		at.Type__c			 = 'Email';
		   		at.Priority__c		 = 'Low';
		   		at.ActionPlanTask__c = ( i > 0 ) ? aptt[ i-1 ].Id : null;
		   		insert at;
		   		aptt.add(at);
		   		apTTaskIds.add( at.Id );
		   		
		   		if( i == 0 ){
		   			Task x 				= new Task();
		   			x.Priority 			= at.Priority__c;
		   			x.Status			= 'Open';
		   			x.TaskTemplateId__c	= at.Id;
		   			x.Subject			= at.Subject__c;
		   			insert x;
		   		}
		   	}
	 	
		   	apTask = [Select Status, Id from Task where TaskTemplateId__c IN : apTTaskIds]; 
		   	for( Task t : apTask ){ 
		   		t.Status = 'Completed';
		   	} 
	   	
	   		update apTask;
			apTask = [Select Id from Task where TaskTemplateId__c =: apTTaskIds[0] ];
			
		Test.stopTest();
		System.assert( !apTask.isEmpty() );
    }
    
	/**
    * test trigger AP Delete 
    */
    public static testMethod void testTrigger2() {
    	
    	ActionPlansTestUtilities ge = new ActionPlansTestUtilities();
    	ActionPlan__c ap 			= ge.createNewActionPlan( 'accounts', 0 );
    	ap.SkipWeekends__c			= true;
    	update ap;
    	
    	List<Id> apTTaskIds 		= new List<Id>();
    	List<Task> apTask 			= new List<Task>();
    	List<ActionPlanTask__c> aptt = new List<ActionPlanTask__c>();
		
		Test.startTest();
		   	for( Integer i = 0; i < 4; i++ ){
		   		ActionPlanTask__c at = new ActionPlanTask__c();
		   		at.Action_Plan__c 	 = ap.Id;
		   		at.DaysFromStart__c  = 2.0;
		   		at.User__c			 = ge.createTestUser().Id;
		   		at.SendEmail__c		 = false;
		   		at.Subject__c		 = 'Test '+ i;
		   		at.Type__c			 = 'Email';
		   		at.Priority__c		 = 'Low';
		   		at.Comments__c		 = 'My Coment';
		   		at.Reminder__c		 = true;
		   		at.ActionPlanTask__c = ( i > 0 ) ? aptt[ i-1 ].Id : null;
		   		insert at;
		   		aptt.add(at);
		   		apTTaskIds.add( at.Id );
		   		
		   		if( i == 0 ){
		   			Task x 				= new Task();
		   			x.Priority 			= at.Priority__c;
		   			x.Status			= 'Open';
		   			x.TaskTemplateId__c	= at.Id;
		   			x.Subject			= at.Subject__c;
		   			insert x;
		   		}
		   	}
		   	delete ap;
		   	apTask = [Select Id from Task where TaskTemplateId__c =: apTTaskIds[1] ];
		   	
		Test.stopTest(); 
		
		System.assert( apTask.isEmpty() );
    }
    
    /**
    * test trigger  
    */
    public static testMethod void testTrigger3() {
    	
    	ActionPlansTestUtilities ge = new ActionPlansTestUtilities();
    	ActionPlan__c ap 			= ge.createNewActionPlan( 'accounts', 0 );
    	ap.SkipWeekends__c			= true;
    	update ap;
    	
    	List<Id> apTTaskIds 		= new List<Id>();
    	List<Task> apTask 			= new List<Task>();
    	List<ActionPlanTask__c> aptt = new List<ActionPlanTask__c>();
		
		Test.startTest();
		   	for( Integer i = 0; i < 4; i++ ){
		   		ActionPlanTask__c at = new ActionPlanTask__c();
		   		at.Action_Plan__c 	 = ap.Id;
		   		at.DaysFromStart__c  = 2.0;
		   		at.User__c			 = ge.createTestUser().Id;
		   		at.SendEmail__c		 = false;
		   		at.Subject__c		 = 'Test '+ i;
		   		at.Type__c			 = 'Email';
		   		at.Priority__c		 = 'Low';
		   		at.Comments__c		 = 'My Coment';
		   		at.Reminder__c		 = true;
		   		at.Minutes_Reminder__c = '510';
		   		at.ActionPlanTask__c = ( i > 0 ) ? aptt[ i-1 ].Id : null;
		   		insert at;
		   		aptt.add(at);
		   		apTTaskIds.add( at.Id );
		   		
		   		if( i == 0 ){
		   			Task x 				= new Task();
		   			x.Priority 			= at.Priority__c;
		   			x.Status			= 'Open';
		   			x.TaskTemplateId__c	= at.Id;
		   			x.Subject			= at.Subject__c;
		   			insert x;
		   		}
		   	}
		   	
		   	
		   	apTask = [Select Status, Id from Task where TaskTemplateId__c IN : apTTaskIds]; 
		   	for( Task t : apTask ){
		   		t.Status = 'Completed';
		   	} 
		   	update apTask;
		   	apTask = [Select Id from Task where TaskTemplateId__c =: apTTaskIds[0] ];
		   	
		Test.stopTest(); 
		
		System.assert( !apTask.isEmpty() );
    }
    
   /**
    * 	test ActionPlanTaskTemplateTrigger
    *	When the user undeletes an ActionPlan Task Template  
    */
    public static testMethod void testTrigger4() {
    	Test.startTest();
    	ActionPlansTestUtilities ge = new ActionPlansTestUtilities();
    	
    	ActionPlan__c ap 			= ge.createNewActionPlan( 'accounts', 1 );
    	ap.SkipWeekends__c			= true;
    	update ap;
    	
		// select the APTask Template
   		ActionPlanTask__c at = [select id, Subject__c, Priority__c, User__c from ActionPlanTask__c where Action_Plan__c =: ap.id limit 1];
	   		
		// create the related Task
   		Task t 				= new Task();
   		t.Subject           = at.Subject__c;
		t.Priority          = at.Priority__c;
		t.OwnerId           = at.User__c;
		t.TaskTemplateId__c = at.Id; 
	   	insert t;
		   	
		// delete the APTask Template 
	   	delete at;
	   	delete t;
	   	List<ActionPlanTask__c> apttDel = [select id from ActionPlanTask__c where id =: at.Id];
		System.assert(apttDel.size() == 0);	
	   	
	   	// undelete task and APTask and get exception
	   	List <String> ids = new List <String>();
		ids.add(t.Id);
		ids.add(at.Id);
		try{
			database.undelete (ids);
		}catch(Dmlexception e){
			System.assert( e.getMessage().contains('BROKEN'),e.getMessage() );
		}
	   	
	   	// now undelete and trigger the code
	   	if ([select id from ActionPlanTask__c where id =: at.Id and isDeleted = true ].size() >0){
			undelete at;	   	
		   	List<ActionPlanTask__c> apttUnDel = [select id from ActionPlanTask__c where id =: at.Id];
			System.assert(apttUnDel.size() == 1);	
		}
	   	
		   	
		Test.stopTest(); 

    }

	/**
    * 	test ActionPlanTaskTemplateTrigger
    *	When the user undeletes an ActionPlan Task Template  
    */
    public static testMethod void testTrigger5() {
    	Test.startTest();
    	ActionPlansTestUtilities ge = new ActionPlansTestUtilities();
    	
    	ActionPlan__c ap 			= ge.createNewActionPlan( 'accounts', 3 );
    	ap.SkipWeekends__c			= true;
    	update ap;
    	
		// select the APTask Template
   		ActionPlanTask__c at = [select id, Subject__c, Priority__c, User__c from ActionPlanTask__c where Action_Plan__c =: ap.id limit 1];
	   		
		// create the related Task
   		Task t 				= new Task();
   		t.Subject           = at.Subject__c;
		t.Priority          = at.Priority__c;
		t.OwnerId           = at.User__c;
		t.TaskTemplateId__c = at.Id; 
	   	insert t;
		   	
		// delete the APTask Template 
	   	delete at;
	   	delete t;
	   	Database.emptyRecycleBin(t);
	   	List<ActionPlanTask__c> apttDel = [select id from ActionPlanTask__c where id =: at.Id];
		System.assert(apttDel.size() == 0);	
	   	
	   	// undelete task and APTask and get exception
	   	List <String> ids = new List <String>();
		ids.add(at.Id);
		try{
			database.undelete (ids);
		}catch(Dmlexception e){
			System.assert( e.getMessage().contains('BROKEN'),e.getMessage() );
		}
	   	   	
		Test.stopTest(); 

    }	
    /*
	     method for testing Task  After Update trigger
	     when updating task to status 'In progress'
    
    */
	public static testMethod void testTrigger6() {
		
		ActionPlansTestUtilities ge = new ActionPlansTestUtilities();
		ActionPlan__c ap 			= ge.createNewActionPlan( 'accounts', 0 );
		
		
		List<Id> apTTaskIds 		= new List<Id>();
		List<Task> apTask 			= new List<Task>();
		List<ActionPlanTask__c> aptt = new List<ActionPlanTask__c>();
		
		Test.startTest();
		   	for( Integer i = 0; i < 4; i++ ){
		   		ActionPlanTask__c at = new ActionPlanTask__c();
		   		at.Action_Plan__c 	 = ap.Id;
		   		at.DaysFromStart__c  = 2.0;
		   		at.User__c			 = ge.createTestUser().Id;
		   		if (i == 0){
		   			at.SendEmail__c		 = true;
		   		}else{
		   			at.SendEmail__c		 = false;
		   		}
		   		at.Subject__c		 = 'Test '+ i;
		   		at.Type__c			 = 'Email';
		   		at.Priority__c		 = 'Low';
		   		at.ActionPlanTask__c = ( i > 0 ) ? aptt[ i-1 ].Id : null;
		   		insert at;
		   		aptt.add(at);
		   		apTTaskIds.add( at.Id );
		   		
		   		if( i == 0 ){
		   			Task x 				= new Task();
		   			x.Priority 			= at.Priority__c;
		   			x.Status			= 'Open';
		   			x.TaskTemplateId__c	= at.Id;
		   			x.Subject			= at.Subject__c;
		   			insert x;
		   		}
		   	}
	 	
	   	apTask = [Select Status, Id from Task where TaskTemplateId__c IN : apTTaskIds]; 
	   	for( Task t : apTask ){ 
	   		t.Status = 'In Progress';
	   	} 
   	
   		update apTask;
		apTask = [Select Id from Task where TaskTemplateId__c =: apTTaskIds[0] ];
			
		Test.stopTest();
		System.assert( !apTask.isEmpty() );
	}  
	  
   /*
	     method for testing Task  before delete trigger
    
    */
	public static testMethod void testTrigger7() {
		
		
		test.startTest();
		ActionPlansTestUtilities ge = new ActionPlansTestUtilities();
		ActionPlan__c ap 			= ge.createNewActionPlan( 'accounts', 0 );
				
		//Task Template 1
		ActionPlanTask__c at = new ActionPlanTask__c();
		at.Action_Plan__c 	 = ap.Id;
		at.DaysFromStart__c  = 2.0;
		at.User__c				= ge.createTestUser().Id;
		at.SendEmail__c			= true;
		at.Subject__c			= 'Test ';
		at.Type__c				= 'Email';
		at.Priority__c			= 'Low';
		at.ActionPlanTask__c	= null; 
		at.taskIndex__c			=0;
		insert at;
		//Task Template 2
		ActionPlanTask__c at2 = new ActionPlanTask__c();
		at2.Action_Plan__c		= ap.Id;
		at2.DaysFromStart__c	= 2.0;
		at2.User__c				= ge.createTestUser().Id;
		at2.SendEmail__c		= true;
		at2.Subject__c			= 'Test2' ;
		at2.Type__c				= 'Email';
		at2.Priority__c			= 'Low';
		at2.ActionPlanTask__c	=at.Id;
		at2.taskIndex__c			=1;
		insert at2;
		
		//create task for task template 1		   		
		Task x 				= new Task();
		x.Priority 			= at.Priority__c;
		x.Status			= 'Open';
		x.TaskTemplateId__c	= at.Id;
		x.Subject			= at.Subject__c;
		insert x;

		ActionPlansTaskTriggerUtilities aptt = new ActionPlansTaskTriggerUtilities();
		ActionPlansTaskTriggerUtilities.generateActioPlanFeeds(new List<String>{ap.Id});
		
		//delete task 
		delete x;
		   	
		test.stopTest();
		//check if the dependet task was created
		
		List<Task> newTask = [Select Status, Id from Task where TaskTemplateId__c =: at2.Id ]; 
		System.assert( !newTask.isEmpty() );
		
	}    
		
}