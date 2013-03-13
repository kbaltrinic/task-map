exports.get = (config) ->

  (req, res) -> 
    res.json [
      title: "Test Task 1"
      order: 1
      done: false
    ,
      title: "Test Task 2"
      order: 2
      done: true
    ,
      title: "Test Task 3"
      order: 3
      done: false
    ]
