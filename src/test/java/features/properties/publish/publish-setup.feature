@ignore
Feature: Setup - Registrar arrendador y arrendatario para pruebas de publicacion

  Scenario: Crear usuarios de prueba
    * def utils = call read('classpath:features/common/common-utils.feature')
    * def uuid = utils.uuid()
    * def timestamp = utils.timestamp()

    # Registrar arrendador
    * def landlordEmail = 'landlord_pub_' + uuid + '@test.com'
    * def landlordDocId = 'LP' + uuid
    * def authLandlord = call read('classpath:features/common/auth.feature') { name: 'Arrendador Test', email: '#(landlordEmail)', password: 'Pass1234!', phone: '3101234567', documentType: 'CC', documentId: '#(landlordDocId)', role: 'LANDLORD' }
    * def landlordJwt = authLandlord.jwtCookie

    # Registrar arrendatario
    * def tenantEmail = 'tenant_pub_' + uuid + '@test.com'
    * def tenantDocId = 'TP' + uuid
    * def authTenant = call read('classpath:features/common/auth.feature') { name: 'Arrendatario Test', email: '#(tenantEmail)', password: 'Pass5678!', phone: '3209876543', documentType: 'CC', documentId: '#(tenantDocId)', role: 'TENANT' }
    * def tenantJwt = authTenant.jwtCookie
