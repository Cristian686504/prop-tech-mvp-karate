@hu004 @boundary @descripcion
Feature: HU004 - Publicar Propiedad - Valores limite de la descripcion (max 2000)

  Particion de equivalencia y valores limite para el campo descripcion

  Background:
    * url baseUrl
    * def setup = callonce read('classpath:features/properties/publish/publish-setup.feature')
    * def landlordJwt = setup.landlordJwt
    * def validProperty = read('classpath:data/properties/valid-property.json')

  # ===========================================================================
  #  TC-043, TC-044, TC-045 - Descripcion dentro del limite (1, 1999, 2000 chars)
  # ===========================================================================
  @TC-043 @TC-044 @TC-045
  Scenario Outline: Publicacion exitosa con descripcion de <longitud> caracteres (<tcId>)
    * def descGenerada = 'C'.repeat(<longitud>)
    * copy prop = validProperty
    * set prop.description = descGenerada
    Given path propertiesPath
    And cookie jwt = landlordJwt
    And request prop
    When method POST
    Then status 201

    Examples:
      | tcId   | longitud | nota                          |
      | TC-043 | 1        | limite inferior (1 char)      |
      | TC-044 | 1999     | cercano al limite (1999)      |
      | TC-045 | 2000     | limite exacto (2000)          |

  # ===========================================================================
  #  TC-046 - Descripcion excede el limite (2001 chars)
  # ===========================================================================
  @TC-046
  Scenario: Publicacion fallida con descripcion de 2001 caracteres (TC-046)
    * def descGenerada = 'C'.repeat(2001)
    * copy prop = validProperty
    * set prop.description = descGenerada
    Given path propertiesPath
    And cookie jwt = landlordJwt
    And request prop
    When method POST
    Then status 400
