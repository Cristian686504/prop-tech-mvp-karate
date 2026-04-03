@hu004 @validation
Feature: HU004 - Publicar Propiedad - Campos obligatorios

  Validar que el sistema rechaza la publicacion cuando faltan campos requeridos

  Background:
    * url baseUrl
    * def setup = callonce read('classpath:features/properties/publish/publish-setup.feature')
    * def landlordJwt = setup.landlordJwt

  # ===========================================================================
  #  TC-030 a TC-032, TC-034 - Campos obligatorios vacios (Scenario Outline)
  # ===========================================================================
  @TC-030 @TC-031 @TC-032 @TC-033 @TC-034
  Scenario Outline: Publicacion fallida por campo obligatorio vacio - <campo> (<tcId>)
    Given path propertiesPath
    And cookie jwt = landlordJwt
    And request
      """
      {
        "title":       "<titulo>",
        "description": "<descripcion>",
        "address":     "<direccion>",
        "price":       <precio>,
        "imageUrls":   <imagenes>
      }
      """
    When method POST
    Then status 400

    Examples:
      | tcId   | campo       | titulo             | direccion              | descripcion                   | precio  | imagenes                                  |
      | TC-030 | titulo      |                    | Cra 7 #45-12, Bogota   | Apartamento de 2 habitaciones | 1500000 | ["https://example.com/img/prop1.jpg"]     |
      | TC-031 | direccion   | Apartamento Centro |                        | Apartamento de 2 habitaciones | 1500000 | ["https://example.com/img/prop1.jpg"]     |
      | TC-032 | descripcion | Apartamento Centro | Cra 7 #45-12, Bogota   |                               | 1500000 | ["https://example.com/img/prop1.jpg"]     |
      | TC-033 | precio      | Apartamento Centro | Cra 7 #45-12, Bogota   | Apartamento de 2 habitaciones |         | ["https://example.com/img/prop1.jpg"]     |
      | TC-034 | imagenes    | Apartamento Centro | Cra 7 #45-12, Bogota   | Apartamento de 2 habitaciones | 1500000 | []                                        |
