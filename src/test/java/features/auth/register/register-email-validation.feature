@hu001 @validation @email
Feature: HU001 - Registro de usuario - Validacion de formato de correo electronico

  Particion de equivalencia para formatos invalidos de correo electronico

  Background:
    * url baseUrl

  # ===========================================================================
  #  TC-009, TC-010, TC-011 - Formato de email invalido -> 400
  # ===========================================================================
  @TC-009 @TC-010 @TC-011
  Scenario Outline: Registro fallido con correo con formato invalido - <tcId>
    Given path authRegisterPath
    And request
      """
      {
        "name":         "Juan Perez",
        "email":        "<emailInvalido>",
        "password":     "Pass1234!",
        "phone":        "3101234567",
        "documentType": "CC",
        "documentId":   "<docId>",
        "role":         "LANDLORD"
      }
      """
    When method POST
    Then status 400

    Examples:
      | tcId   | emailInvalido | docId  |
      | TC-009 | juanemail.com | DOC009 |
      | TC-010 | juan@         | DOC010 |
      | TC-011 | juan@email    | DOC011 |
