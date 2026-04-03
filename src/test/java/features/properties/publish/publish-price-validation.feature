@hu004 @precio
Feature: HU004 - Publicar Propiedad - Validacion del precio

  Particion de equivalencia y valores limite para el campo precio:
  - Clase invalida: negativo, cero, no numerico
  - Clase valida: entero positivo (>0)

  Background:
    * url baseUrl
    * def setup = callonce read('classpath:features/properties/publish/publish-setup.feature')
    * def landlordJwt = setup.landlordJwt
    * def validProperty = read('classpath:data/properties/valid-property.json')

  # ===========================================================================
  #  TC-047 - Precio no numerico
  # ===========================================================================
  @TC-047 @boundary
  Scenario: Publicacion fallida con precio no numerico (TC-047)
    Given path propertiesPath
    And cookie jwt = landlordJwt
    And request
      """
      {
        "title":       "#(validProperty.title)",
        "description": "#(validProperty.description)",
        "address":     "#(validProperty.address)",
        "price":       abc,
        "imageUrls":   #(validProperty.imageUrls)
      }
      """
    When method POST
    Then status 400

  # ===========================================================================
  #  TC-048, TC-049 - Precios invalidos (negativo, cero) - Scenario Outline
  # ===========================================================================
  @TC-048 @TC-049 @boundary
  Scenario Outline: Publicacion fallida con precio invalido: <descripcionPrecio> (<tcId>)
    * copy prop = validProperty
    * set prop.price = <precio>
    Given path propertiesPath
    And cookie jwt = landlordJwt
    And request prop
    When method POST
    Then status 400

    Examples:
      | tcId   | precio | descripcionPrecio  |
      | TC-048 | -100   | precio negativo    |
      | TC-049 | 0      | precio cero        |

  # ===========================================================================
  #  TC-050 - Precio minimo valido (1)
  # ===========================================================================
  @TC-050 @boundary
  Scenario: Publicacion exitosa con precio minimo valido (1) (TC-050)
    * copy prop = validProperty
    * set prop.price = 1
    Given path propertiesPath
    And cookie jwt = landlordJwt
    And request prop
    When method POST
    Then status 201
    And match response.price == 1
