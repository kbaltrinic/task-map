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
        closure = (description, input) ->
          it "Inputing " + description + " should create no tasks.", () ->
            wasCalled = false
            Service.parse input, () -> wasCalled = true
            expect(wasCalled).toBe false
        closure description, input
        
    describe 'Task-per-line', () ->

      scenarios = [
          input: "task1"
          output: [ { title : 'task1' , tasks: [] } ]
        , 
          input: "\n\t task1 \t \n"
          output: [ { title : 'task1' , tasks: [] } ]
        , 
          input: "task1\ntask2"
          output: [ { title : 'task1' , tasks: [] }, { title : 'task2' , tasks: [] } ]
        ,
          input: "\t  \ntask1\n\ntask2\n  \n\t\n"
          output: [ { title : 'task1' , tasks: [] }, { title : 'task2' , tasks: [] } ]
        ]

      for scenario in scenarios
        closure = (scenario) ->
          it "Inputing " + JSON.stringify(scenario.input) + " should create tasks: " + JSON.stringify(scenario.output), () ->
            results = []
            Service.parse scenario.input, (task) -> results.push task
            expect(results).toEqual scenario.output      
        closure scenario
        
    describe 'Indentation creates subtasks', () ->

      scenarios = [
          input: "task1\n task 1a"
          output: [ 
            title: 'task1'
            tasks: [
              title : 'task 1a' 
              tasks: []
            ]
          ]
        , 
          input: "task1\n\ttask 1a"
          output: [ 
            title: 'task1'
            tasks: [
              title : 'task 1a' 
              tasks: []
            ]
          ]
        , 
          input: "task1\n\ttask 1a\ntask2"
          output: [ 
            title: 'task1'
            tasks: [
              title : 'task 1a' 
              tasks: []
            ]
          ,
            title: "task2"
            tasks: []
          ]
        , 
          input: "task1\n\ task 1a\n  task 1a1\ntask2"
          output: [ 
            title: 'task1'
            tasks: [
              title : 'task 1a' 
              tasks: [
                title : 'task 1a1' 
                tasks: []
              ]
            ]
          ,
            title: "task2"
            tasks: []
          ]
        , 
          input: "\ttask1\n\t\t\ttask 1a\n\t\t\t\ttask 1a1\n\t\ttask 1b\ntask2"
          output: [ 
            title: 'task1'
            tasks: [
              title : 'task 1a' 
              tasks: [
                title : 'task 1a1' 
                tasks: []
              ]
            ,
              title : 'task 1b'
              tasks: []
            ]
          ,
            title: "task2"
            tasks: []
          ]
        ]

      for scenario in scenarios
        closure = (scenario)->
          it "Inputing " + JSON.stringify(scenario.input) + " should create tasks: " + JSON.stringify(scenario.output), () ->
            results = []
            Service.parse scenario.input, (task) -> results.push task
            expect(results).toEqual scenario.output
        closure scenario
      return
      