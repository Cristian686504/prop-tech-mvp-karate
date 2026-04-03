@hu004 @security
Feature: HU004 - Publicar Propiedad - Seguridad y autorizacion

  Verificar que solo arrendadores autenticados pueden publicar propiedades

  Background:
    * url baseUrl
    * def setup = callonce read('classpath:features/properties/publish/publish-setup.feature')
    * def tenantJwt = setup.tenantJwt
    * def validProperty = read('classpath:data/properties/valid-property.json')

  # ===========================================================================
  #  TC-055 - Usuario con rol incorrecto (arrendatario intenta publicar)
  # ===========================================================================
  @TC-055
  Scenario: Publicacion fallida con rol arrendatario (TC-055)
    Given path propertiesPath
    And cookie jwt = tenantJwt
    And request validProperty
    When method POST
    Then status 403
