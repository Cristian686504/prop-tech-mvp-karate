// =============================================================================
//  karate-config.js  â€“  ConfiguraciÃ³n global del proyecto Karate
//  Este archivo se carga automÃ¡ticamente al iniciar cada test.
//  Todas las variables que retorne el JSON estarÃ¡n disponibles en los .feature.
// =============================================================================
function fn() {

  // Leer el ambiente desde la variable de sistema (default: 'dev')
  // Desde Maven: mvn test -Dkarate.env=staging
  var env = karate.env || 'dev';
  karate.log('Ambiente activo:', env);

  // ---------------------------------------------------------------------------
  // ConfiguraciÃ³n base por ambiente
  // ---------------------------------------------------------------------------
  var config = {
    env:     env,
    baseUrl: 'https://api.example.com'
  };

  if (env === 'staging') {
    config.baseUrl = 'https://staging.api.example.com';
  }

  if (env === 'prod') {
    config.baseUrl = 'https://api.example.com';
  }

  // ---------------------------------------------------------------------------
  // AutenticaciÃ³n global (descomentar si se necesita)
  // Llama a common/auth.feature una sola vez por suite y reutiliza el token.
  // ---------------------------------------------------------------------------
  // var auth = karate.callSingle('classpath:features/common/auth.feature', config);
  // config.authToken = auth.token;

  // ---------------------------------------------------------------------------
  // ConfiguraciÃ³n de HTTP
  // ---------------------------------------------------------------------------
  karate.configure('connectTimeout', 10000);
  karate.configure('readTimeout',    30000);

  // Cabeceras globales (se aplican a todos los requests salvo que se sobreescriban)
  // karate.configure('headers', { 'x-api-key': 'TU_API_KEY' });

  return config;
}
