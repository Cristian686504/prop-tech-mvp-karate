@hu004 @boundary @direccion
Feature: HU004 - Publicar Propiedad - Valores limite de la direccion (max 255)

  Particion de equivalencia y valores limite para el campo direccion

  Background:
    * url baseUrl
    * def setup = callonce read('classpath:features/properties/publish/publish-setup.feature')
    * def landlordJwt = setup.landlordJwt
    * def validProperty = read('classpath:data/properties/valid-property.json')

  # ===========================================================================
  #  TC-039, TC-040, TC-041 - Direccion dentro del limite (1, 254, 255 chars)
  # ===========================================================================
  @TC-039 @TC-040 @TC-041
  Scenario Outline: Publicacion exitosa con direccion de <longitud> caracteres (<tcId>)
    * def direccionGenerada = 'B'.repeat(<longitud>)
    * copy prop = validProperty
    * set prop.address = direccionGenerada
    Given path propertiesPath
    And cookie jwt = landlordJwt
    And request prop
    When method POST
    Then status 201
    And match response.address == direccionGenerada

    Examples:
      | tcId   | longitud | nota                         |
      | TC-039 | 1        | limite inferior (1 char)     |
      | TC-040 | 254      | cercano al limite (254)      |
      | TC-041 | 255      | limite exacto (255)          |

  # ===========================================================================
  #  TC-042 - Direccion excede el limite (256 chars)
  # ===========================================================================
  @TC-042
  Scenario: Publicacion fallida con direccion de 256 caracteres (TC-042)
    * def direccionGenerada = 'B'.repeat(256)
    * copy prop = validProperty
    * set prop.address = direccionGenerada
    Given path propertiesPath
    And cookie jwt = landlordJwt
    And request prop
    When method POST
    Then status 400
