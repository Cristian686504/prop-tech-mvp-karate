@hu003 @security
Feature: HU003 - Login de usuario - Seguridad en la respuesta

  Verificar que la respuesta no expone datos sensibles como el hash de contrasena

  Background:
    * url baseUrl
    * def setup = callonce read('classpath:features/auth/register/register-setup.feature')
    * def existingEmail = setup.existingEmail

  # ===========================================================================
  #  TC-027 - Respuesta de login no expone passwordHash
  # ===========================================================================
  @TC-027
  Scenario: Login exitoso no expone el hash de contrasena en la respuesta (TC-027)
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
    # Campos esperados en la respuesta
    And match response.id    == '#notnull'
    And match response.name  == '#notnull'
    And match response.email == existingEmail
    And match response.role  == '#notnull'
    # El hash de contrasena NO debe aparecer en la respuesta
    And match response.passwordHash == '#notpresent'
    And match response.password     == '#notpresent'
