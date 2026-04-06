@hu001 @hu002 @happy-path
Feature: HU001/HU002 - Registro de usuario - Camino feliz

  Verificar que un arrendador y un arrendatario se pueden registrar con datos validos

  Background:
    * url baseUrl
    * def utils = call read('classpath:features/common/common-utils.feature')

  # ===========================================================================
  #  TC-001 - Registro exitoso con rol LANDLORD
  # ===========================================================================
  @TC-001
  Scenario: Registro exitoso de arrendador con datos validos (TC-001)
    * def uuid = utils.uuid()
    * def email = 'landlord_hp_' + uuid + '@test.com'
    Given path authRegisterPath
    And request
      """
      {
        "name":         "Juan Perez",
        "email":        "#(email)",
        "password":     "Pass1234!",
        "phone":        "3101234567",
        "documentType": "CC",
        "documentId":   "LP#(uuid)",
        "role":         "LANDLORD"
      }
      """
    When method POST
    Then status 201
    And match response.id == '#notnull'
    And match response.name == 'Juan Perez'
    And match response.email == email
    And match response.role == 'LANDLORD'
    And match responseCookies.jwt == '#notnull'

  # ===========================================================================
  #  TC-019 - Registro exitoso con rol TENANT
  # ===========================================================================
  @TC-019
  Scenario: Registro exitoso de arrendatario con datos validos (TC-019)
    * def uuid = utils.uuid()
    * def email = 'tenant_hp_' + uuid + '@test.com'
    Given path authRegisterPath
    And request
      """
      {
        "name":         "Maria Lopez",
        "email":        "#(email)",
        "password":     "Pass5678!",
        "phone":        "3209876543",
        "documentType": "CC",
        "documentId":   "TP#(uuid)",
        "role":         "TENANT"
      }
      """
    When method POST
    Then status 201
    And match response.id == '#notnull'
    And match response.name == 'Maria Lopez'
    And match response.email == email
    And match response.role == 'TENANT'
    And match responseCookies.jwt == '#notnull'
