@hu001 @validation @telefono
Feature: HU001 - Registro de usuario - Validacion del numero de telefono

  Particion de equivalencia para el campo telefono (formato colombiano 10 digitos)

  Background:
    * url baseUrl
    * def utils = call read('classpath:features/common/common-utils.feature')

  # ===========================================================================
  #  TC-016 - Telefono con exactamente 10 digitos numericos -> 201
  # ===========================================================================
  @TC-016
  Scenario: Registro exitoso con telefono de 10 digitos (TC-016)
    * def uuid = utils.uuid()
    * def email = 'tc016_' + uuid + '@test.com'
    Given path authRegisterPath
    And request
      """
      {
        "name":         "Juan Perez",
        "email":        "#(email)",
        "password":     "Pass1234!",
        "phone":        "3101234567",
        "documentType": "CC",
        "documentId":   "PH16#(uuid)",
        "role":         "TENANT"
      }
      """
    When method POST
    Then status 201

  # ===========================================================================
  #  TC-014, TC-015, TC-017 - Telefono con formato invalido -> 400
  # ===========================================================================
  @TC-014 @TC-015 @TC-017
  Scenario Outline: Registro fallido con telefono invalido - <tcId>
    Given path authRegisterPath
    And request
      """
      {
        "name":         "Juan Perez",
        "email":        "<email>",
        "password":     "Pass1234!",
        "phone":        "<telefono>",
        "documentType": "CC",
        "documentId":   "<docId>",
        "role":         "LANDLORD"
      }
      """
    When method POST
    Then status 400

    Examples:
      | tcId   | telefono    | email           | docId  |
      | TC-014 | 31012345ab  | tc014@test.com  | DOC014 |
      | TC-015 | 310123456   | tc015@test.com  | DOC015 |
      | TC-017 | 31012345678 | tc017@test.com  | DOC017 |
