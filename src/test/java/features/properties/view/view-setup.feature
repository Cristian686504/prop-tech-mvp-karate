@ignore
Feature: Setup - Registrar usuarios para pruebas de visualizacion de propiedades

  Scenario: Crear usuarios y propiedad de prueba
    * def utils = call read('classpath:features/common/common-utils.feature')
    * def uuid = utils.uuid()
    * def timestamp = utils.timestamp()

    # Registrar arrendador
    * def landlordEmail = 'landlord_view_' + uuid + '@test.com'
    * def landlordDocId = 'LV' + uuid
    * def authLandlord = call read('classpath:features/common/auth.feature') { name: 'Arrendador HU005', email: '#(landlordEmail)', password: 'Pass1234!', phone: '3101234567', documentType: 'CC', documentId: '#(landlordDocId)', role: 'LANDLORD' }
    * def landlordJwt = authLandlord.jwtCookie

    # Registrar arrendatario
    * def tenantEmail = 'tenant_view_' + uuid + '@test.com'
    * def tenantDocId = 'TV' + uuid
    * def authTenant = call read('classpath:features/common/auth.feature') { name: 'Arrendatario HU005', email: '#(tenantEmail)', password: 'Pass5678!', phone: '3209876543', documentType: 'CC', documentId: '#(tenantDocId)', role: 'TENANT' }
    * def tenantJwt = authTenant.jwtCookie
