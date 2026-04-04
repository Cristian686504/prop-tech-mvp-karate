@hu005
Feature: HU005 - Visualizar Propiedades Disponibles

  Como arrendatario (inquilino)
  Quiero visualizar las propiedades disponibles para alquilar
  Para poder elegir una propiedad que se ajuste a mis necesidades

  Background:
    * url baseUrl
    * def setup = callonce read('classpath:features/properties/view/view-setup.feature')
    * def landlordJwt = setup.landlordJwt
    * def tenantJwt = setup.tenantJwt
    * def timestamp = setup.timestamp

  # ===========================================================================
  #  TC-057-detalle - Validar contenido exacto de propiedad creada
  # ===========================================================================
  @TC-057-detalle @happy-path
  Scenario: Verificar que las propiedades listadas contienen los datos correctos
    * def propTitle = 'Casa Campestre Verificacion ' + timestamp
    Given path propertiesPath
    And cookie jwt = landlordJwt
    And request
      """
      {
        "title":       "#(propTitle)",
        "description": "Casa amplia con jardin y piscina para verificar detalle",
        "address":     "Cll 80 #11-45, Medellin",
        "price":       3500000,
        "imageUrls":   ["https://example.com/img/casa1.jpg", "https://example.com/img/casa2.jpg"]
      }
      """
    When method POST
    Then status 201
    * def propiedadId = response.id

    # Consultar y verificar presencia
    Given path propertiesPath
    And cookie jwt = tenantJwt
    When method GET
    Then status 200
    * def encontrada = karate.filter(response.content, function(x){ return x.id == propiedadId })
    And match encontrada == '#[1]'
    And match encontrada[0].title == propTitle
    And match encontrada[0].description == 'Casa amplia con jardin y piscina para verificar detalle'
    And match encontrada[0].address == 'Cll 80 #11-45, Medellin'
    And match encontrada[0].price == 3500000
    And match encontrada[0].imageUrls == '#[2]'
    And match encontrada[0].status == 'AVAILABLE'
