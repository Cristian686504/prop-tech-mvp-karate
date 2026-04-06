@hu003 @validation
Feature: HU003 - Login de usuario - Credenciales invalidas

  Equivalencia: email inexistente o contrasena incorrecta -> 401

  Background:
    * url baseUrl
    * def setup = callonce read('classpath:features/auth/register/register-setup.feature')
    * def existingEmail = setup.existingEmail

  # ===========================================================================
  #  TC-024 - Email no registrado -> 401
  # ===========================================================================
  @TC-024
  Scenario: Login fallido con correo no registrado (TC-024)
    Given path authLoginPath
    And request
      """
      {
        "email":    "noexiste@test.com",
        "password": "Pass1234!"
      }
      """
    When method POST
    Then status 401

  # ===========================================================================
  #  TC-025 - Contrasena incorrecta para email existente -> 401
  # ===========================================================================
  @TC-025
  Scenario: Login fallido con contrasena incorrecta (TC-025)
    Given path authLoginPath
    And request
      """
      {
        "email":    "#(existingEmail)",
        "password": "WrongPass!"
      }
      """
    When method POST
    Then status 401
