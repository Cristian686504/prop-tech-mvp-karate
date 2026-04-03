@ignore
Feature: Autenticacion - registrar usuario y obtener token JWT

  # Helper reutilizable. Se invoca con karate.call() pasando las variables necesarias.

  Scenario: Registrar usuario y obtener JWT cookie
    # Registrar
    Given url baseUrl
    And path authRegisterPath
    And request
      """
      {
        "name":         "#(name)",
        "email":        "#(email)",
        "password":     "#(password)",
        "phone":        "#(phone)",
        "documentType": "#(documentType)",
        "documentId":   "#(documentId)",
        "role":         "#(role)"
      }
      """
    When method POST
    Then status 201

    # Login para obtener cookie JWT
    Given url baseUrl
    And path authLoginPath
    And request { "email": "#(email)", "password": "#(password)" }
    When method POST
    Then status 200
    * def jwtCookie = responseCookies.jwt.value
