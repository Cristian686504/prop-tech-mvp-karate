@hu003 @validation @email
Feature: HU003 - Login de usuario - Validacion de formato de correo

  Particion de equivalencia: email con formato invalido -> 400

  Background:
    * url baseUrl

  # ===========================================================================
  #  TC-026 - Formato de email invalido -> 400
  # ===========================================================================
  @TC-026
  Scenario: Login fallido con correo en formato invalido (TC-026)
    Given path authLoginPath
    And request
      """
      {
        "email":    "correo-invalido",
        "password": "Pass1234!"
      }
      """
    When method POST
    Then status 400
