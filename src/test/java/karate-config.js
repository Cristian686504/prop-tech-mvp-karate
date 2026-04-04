// =============================================================================
//  karate-config.js — Configuracion global del proyecto Karate
// =============================================================================
function fn() {

  var env = karate.env || 'dev';
  karate.log('Ambiente activo:', env);

  var config = {
    env:     env,
    baseUrl: 'http://localhost:8080'
  };

  if (env === 'staging') {
    config.baseUrl = 'https://staging.api.example.com';
  }

  if (env === 'prod') {
    config.baseUrl = 'https://api.example.com';
  }

  // ---------------------------------------------------------------------------
  // Paths de la API (centralizados para no hardcodear en los .feature)
  // ---------------------------------------------------------------------------
  config.authRegisterPath  = '/api/auth/register';
  config.authLoginPath     = '/api/auth/login';
  config.propertiesPath    = '/api/properties';

  // ---------------------------------------------------------------------------
  // Configuracion de HTTP
  // ---------------------------------------------------------------------------
  karate.configure('connectTimeout', 10000);
  karate.configure('readTimeout',    30000);

  return config;
}
