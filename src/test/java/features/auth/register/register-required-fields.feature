@hu001 @validation
Feature: HU001 - Registro de usuario - Campos obligatorios

  Verificar que el sistema rechaza el registro cuando faltan campos requeridos

  Background:
    * url baseUrl

  # ===========================================================================
  #  TC-003, TC-008, TC-012, TC-013 - Campos vacios (Scenario Outline)
  #  Emails estaticos: estos requests retornan 400 sin tocar la BD
  # ===========================================================================
  @TC-003 @TC-008 @TC-012 @TC-013
  Scenario Outline: Registro fallido por campo obligatorio vacio - <campo> (<tcId>)
    Given path authRegisterPath
    And request
      """
      {
        "name":         "<nombre>",
        "email":        "<correo>",
        "password":     "<contrasena>",
        "phone":        "<telefono>",
        "documentType": "CC",
        "documentId":   "DOC001",
        "role":         "LANDLORD"
      }
      """
    When method POST
    Then status 400

    Examples:
      | tcId   | campo            | nombre | correo              | contrasena | telefono   |
      | TC-003 | nombre vacio     |        | tc003@test.com      | Pass1234!  | 3101234567 |
      | TC-008 | correo vacio     | Juan   |                     | Pass1234!  | 3101234567 |
      | TC-012 | contrasena vacia | Juan   | tc012@test.com      |            | 3101234567 |
      | TC-013 | telefono vacio   | Juan   | tc013@test.com      | Pass1234!  |            |

  # ===========================================================================
  #  TC-004 - Nombre con solo espacios en blanco
  #  Se define como Scenario independiente para garantizar que se envian espacios
  # ===========================================================================
  @TC-004
  Scenario: Registro fallido con nombre de solo espacios en blanco (TC-004)
    * def nombreEspacios = '   '
    Given path authRegisterPath
    And request
      """
      {
        "name":         "#(nombreEspacios)",
        "email":        "tc004@test.com",
        "password":     "Pass1234!",
        "phone":        "3101234567",
        "documentType": "CC",
        "documentId":   "DOC004",
        "role":         "LANDLORD"
      }
      """
    When method POST
    Then status 400
