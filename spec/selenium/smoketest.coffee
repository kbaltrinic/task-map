WebDriver   = require 'selenium-webdriver'
Selenium    = require 'selenium-webdriver/remote'

class SmokeTest
    
    constructor: () ->
      debugger
      @server = new Selenium.SeleniumServer(
        jar: "spec/server/selenium-server.standalone-2.31.0.jar"
        port: 4444)

      @server.start();
      
      driver = new WebDriver.Builder().
        usingServer(@server.address()).
        withCapabilities(
          'browserName': 'chrome').
        build();
      
      driver.get("http://localhost:3000");
      
      input = driver.findElement WebDriver.By.id 'new-todo'
      existingTasks = driver.findElement WebDriver.By.xpath "//ul[@id='todo-list']/li"
      existingTasks.then (value) ->
        console.log "%d existing tasks found.", value.length
      TASK_NAME = 'Selenium Task 1'
      input.sendKeys TASK_NAME 
      input.sendKeys WebDriver.Key.SHIFT + WebDriver.Key.ENTER
      existingTasks2 = driver.findElement WebDriver.By.xpath "//ul[@id='todo-list']/li"
      existingTasks2.then (value) ->
        console.log "%d existing tasks found.", value.length
      #console.log el.text for el in existingTasks2
      
      #@server.stop()
      
module.exports = new SmokeTest()
      