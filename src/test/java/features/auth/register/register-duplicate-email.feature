@hu001 @validation
Feature: HU001 - Registro de usuario - Correo ya registrado

  Verificar que el sistema rechaza el registro cuando el correo ya existe

  Background:
    * url baseUrl
    * def setup = callonce read('classpath:features/auth/register/register-setup.feature')
    * def existingEmail = setup.existingEmail

  # ===========================================================================
  #  TC-002 - Correo duplicado
  # ===========================================================================
  @TC-002
  Scenario: Registro fallido con correo ya registrado (TC-002)
    Given path authRegisterPath
    And request
      """
      {
        "name":         "Juan Perez",
        "email":        "#(existingEmail)",
        "password":     "Pass1234!",
        "phone":        "3101234567",
        "documentType": "CC",
        "documentId":   "OTRO123",
        "role":         "LANDLORD"
      }
      """
    When method POST
    Then status 409
