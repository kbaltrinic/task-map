require ['app/domain/quick-entry-service-spec'], () ->
    env = jasmine.getEnv() 
    env.addReporter new jasmine.HtmlReporter 
    env.execute() 
