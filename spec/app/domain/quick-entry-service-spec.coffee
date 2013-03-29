define ['../../../public/javascripts/app/domain/quick-entry-service'], (Service) ->

  describe 'QuickEntryService Specs', () ->
      
    service = null
  
    beforeEach () ->
      service = new Service()
    
    describe 'White-space ignored', () ->
      
      scenarios = 
        "an empty string": ""
        "white space": " \t"
        "new lines": "\n \n"
        
      for description, input of scenarios
        it "Inputing " + description + " should create no tasks.", () ->
          wasCalled = false
          Service.parse input, () -> wasCalled = true
          expect(wasCalled).toBe false
          
    describe 'Task-per-line', () ->

      scenarios = [
          input: "task1"
          output: [ { title : 'task1' } ]
        , 
          input: "\n\t task1 \t \n"
          output: [ { title : 'task1' } ]
        , 
          input: "task1\ntask2"
          output: [ { title : 'task1' }, { title : 'task2' } ]
        ,
          input: "\t  \ntask1\n\ntask2\n  \n\t\n"
          output: [ { title : 'task1' }, { title : 'task2' } ]
        ]

      for scenario in scenarios
        it "Inputing " + JSON.stringify(scenario.input) + " should create tasks: " + JSON.stringify(scenario.output), () ->
          results = []
          Service.parse scenario.input, (task) -> results.push task
          expect(results).toEqual scenario.output

      