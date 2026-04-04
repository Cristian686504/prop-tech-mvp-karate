@hu004 @boundary @titulo
Feature: HU004 - Publicar Propiedad - Valores limite del titulo (max 255)

  Particion de equivalencia y valores limite para el campo titulo

  Background:
    * url baseUrl
    * def setup = callonce read('classpath:features/properties/publish/publish-setup.feature')
    * def landlordJwt = setup.landlordJwt
    * def validProperty = read('classpath:data/properties/valid-property.json')

  # ===========================================================================
  #  TC-035, TC-036, TC-037 - Titulo dentro del limite (1, 254, 255 chars)
  # ===========================================================================
  @TC-035 @TC-036 @TC-037
  Scenario Outline: Publicacion exitosa con titulo de <longitud> caracteres (<tcId>)
    * def tituloGenerado = 'A'.repeat(<longitud>)
    * copy prop = validProperty
    * set prop.title = tituloGenerado
    Given path propertiesPath
    And cookie jwt = landlordJwt
    And request prop
    When method POST
    Then status 201
    And match response.title == tituloGenerado

    Examples:
      | tcId   | longitud |
      | TC-035 | 1        |
      | TC-036 | 254      |
      | TC-037 | 255      |

  # ===========================================================================
  #  TC-038 - Titulo excede el limite (256 chars)
  # ===========================================================================
  @TC-038
  Scenario: Publicacion fallida con titulo de 256 caracteres (TC-038)
    * def tituloGenerado = 'A'.repeat(256)
    * copy prop = validProperty
    * set prop.title = tituloGenerado
    Given path propertiesPath
    And cookie jwt = landlordJwt
    And request prop
    When method POST
    Then status 400
