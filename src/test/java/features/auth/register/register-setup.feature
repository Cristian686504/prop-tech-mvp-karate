@ignore
Feature: Setup - Registrar usuario existente para pruebas de registro y login

  Scenario: Crear usuario de prueba con credenciales conocidas
    * def utils = call read('classpath:features/common/common-utils.feature')
    * def uuid = utils.uuid()

    # Usuario landlord con credenciales fijas para pruebas de login y duplicado
    * def existingEmail = 'existing_' + uuid + '@test.com'
    * def existingDocId = 'EX' + uuid
    * def authExisting = call read('classpath:features/common/auth.feature') { name: 'Usuario Existente', email: '#(existingEmail)', password: 'Pass1234!', phone: '3101234567', documentType: 'CC', documentId: '#(existingDocId)', role: 'LANDLORD' }
    * def existingJwt = authExisting.jwtCookie
