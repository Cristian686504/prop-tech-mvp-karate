@ignore
Feature: Common utility functions

  Scenario: Utility library
    * def uuid = function(){ return java.util.UUID.randomUUID().toString().substring(0,8) }
    * def timestamp = function(){ return java.lang.System.currentTimeMillis() + '' }
