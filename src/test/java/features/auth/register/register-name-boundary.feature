@hu001 @boundary @nombre
Feature: HU001 - Registro de usuario - Valores limite del nombre (max 255)

  Particion de equivalencia y valores limite para el campo nombre

  Background:
    * url baseUrl
    * def utils = call read('classpath:features/common/common-utils.feature')

  # ===========================================================================
  #  TC-005, TC-006 - Nombre dentro del limite (1, 255 chars)
  # ===========================================================================
  @TC-005 @TC-006
  Scenario Outline: Registro exitoso con nombre de <longitud> caracteres (<tcId>)
    * def uuid = utils.uuid()
    * def nombreGenerado = 'A'.repeat(<longitud>)
    * def email = 'tc_nb_<tcId>_' + uuid + '@test.com'
    Given path authRegisterPath
    And request
      """
      {
        "name":         "#(nombreGenerado)",
        "email":        "#(email)",
        "password":     "Pass1234!",
        "phone":        "3101234567",
        "documentType": "CC",
        "documentId":   "NB#(uuid)",
        "role":         "LANDLORD"
      }
      """
    When method POST
    Then status 201
    And match response.name == nombreGenerado

    Examples:
      | tcId   | longitud |
      | TC-005 | 1        |
      | TC-006 | 255      |

  # ===========================================================================
  #  TC-007 - Nombre excede el limite (256 chars)
  # ===========================================================================
  @TC-007
  Scenario: Registro fallido con nombre de 256 caracteres (TC-007)
    * def nombreGenerado = 'A'.repeat(256)
    Given path authRegisterPath
    And request
      """
      {
        "name":         "#(nombreGenerado)",
        "email":        "tc007@test.com",
        "password":     "Pass1234!",
        "phone":        "3101234567",
        "documentType": "CC",
        "documentId":   "DOC007",
        "role":         "LANDLORD"
      }
      """
    When method POST
    Then status 400
