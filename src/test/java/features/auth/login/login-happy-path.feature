@hu003 @happy-path
Feature: HU003 - Login de usuario - Flujo exitoso

  Background:
    * url baseUrl
    * def setup = callonce read('classpath:features/auth/register/register-setup.feature')
    * def existingEmail = setup.existingEmail

  # ===========================================================================
  #  TC-020 - Login exitoso con credenciales validas -> 200 + cookie JWT
  # ===========================================================================
  @TC-020
  Scenario: Login exitoso con correo y contrasena validos (TC-020)
    Given path authLoginPath
    And request
      """
      {
        "email":    "#(existingEmail)",
        "password": "Pass1234!"
      }
      """
    When method POST
    Then status 200
    And match responseCookies.jwt == '#notnull'
    And match response.email == existingEmail
    And match response.id    == '#notnull'
    And match response.role  == '#notnull'
