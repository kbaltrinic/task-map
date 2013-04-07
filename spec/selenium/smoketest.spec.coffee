WebDriver   = require 'selenium-webdriver'
Selenium    = require 'selenium-webdriver/remote'

describe 'Selenium Smoke Tests', () ->

  server = null

  it "the page should load", () ->
    driver = new WebDriver.Builder().
      withCapabilities(
        'browserName': 'chrome').
      build()
    actualTitle = null
    runs () ->
      driver.get "http://localhost:3000"
      driver.getTitle().then (title) ->
        actualTitle = title
      ,
        (err) -> console.error(err)

    waitsFor () ->
      actualTitle!=null
    , "Failed to get title", 5000

    runs () ->
        expect(actualTitle).toEqual "Task-Map"
        driver.quit()

