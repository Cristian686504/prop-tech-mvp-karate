@ignore
Feature: AutenticaciÃ³n â€“ obtener token reutilizable

  # Este feature estÃ¡ pensado para ser llamado con karate.callSingle() desde karate-config.js.
  # Al marcarlo con @ignore no se ejecuta como test independiente.
  #
  # Uso en karate-config.js:
  #   var auth = karate.callSingle('classpath:features/common/auth.feature', config);
  #   config.authToken = auth.token;

  Scenario: Login y obtener access token
    Given url baseUrl + '/auth/login'
    And request
      """
      {
        "username": "test-user",
        "password": "test-password"
      }
      """
    When method POST
    Then status 200
    * def token = response.access_token
