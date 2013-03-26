define ['../../../public/javascripts/app/domain/quick-entry-service'], (Service) ->

  describe 'QuickEntryService Specs', () ->
      
    service = null
  
    beforeEach () ->
      service = new Service()
    
    describe 'White-space only Specs', () ->
      
      scenarios = 
        "an empyt string": ""
        "white space": " \t"
        "new lines": "\n \n"
        
      for description, input of scenarios
        it 'should create no tasks for ' + description, () ->
          wasCalled = false
          Service.parse input, () -> wasCalled = true
          expect(wasCalled).toBe false
          
        