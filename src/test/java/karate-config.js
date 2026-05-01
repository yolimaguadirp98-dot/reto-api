function fn() {
    var env = karate.env || 'real';

    karate.log('Ambiente activo:', env);

    var config = {};

    if (env === 'real') {
        config.baseUrl = 'https://webservice.toscacloud.com';
    } else if (env === 'mock') {
        config.baseUrl = 'http://localhost:8090';
    }

    return config;
}