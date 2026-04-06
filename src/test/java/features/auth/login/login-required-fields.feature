@hu003 @validation
Feature: HU003 - Login de usuario - Campos obligatorios vacios

  Particion de equivalencia: campos obligatorios ausentes o vacios -> 400

  Background:
    * url baseUrl

  # ===========================================================================
  #  TC-021, TC-022, TC-023 - Campos vacios -> 400
  # ===========================================================================
  @TC-021 @TC-022 @TC-023
  Scenario Outline: Login fallido con <campo> vacio - <tcId>
    Given path authLoginPath
    And request
      """
      {
        "email":    "<email>",
        "password": "<password>"
      }
      """
    When method POST
    Then status 400

    Examples:
      | tcId   | campo              | email             | password   |
      | TC-021 | email              |                   | Pass1234!  |
      | TC-022 | password           | tc021@test.com    |            |
      | TC-023 | email y contraseña |                   |            |
