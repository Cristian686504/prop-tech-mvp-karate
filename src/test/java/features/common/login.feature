@ignore
Feature: Login - obtener token JWT de un usuario existente

  Scenario: Login y obtener JWT cookie
    Given url baseUrl
    And path authLoginPath
    And request { "email": "#(email)", "password": "#(password)" }
    When method POST
    Then status 200
    * def jwtCookie = responseCookies.jwt.value
