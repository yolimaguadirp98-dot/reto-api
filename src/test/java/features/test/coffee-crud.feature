Feature: Coffee CRUD - Tosca Cloud CoffeeShop API
  As a QA engineer
  I want to validate the complete CRUD flow of the Coffee API
  So that I can ensure data consistency across all operations

  Background:
    * url baseUrl
    * def coffeeId = null

  # BLOQUE 1 + 2 + 3 + 4 + 5 encadenados
  Scenario: Flujo CRUD completo encadenado - Coffee API

    # BLOQUE 1: Creación
    * print '========== BLOQUE 1: CREAR COFFEE =========='
    Given path '/api/v1/Coffees'
    And header Content-Type = 'application/json'
    And request { name: 'Espresso Supremo', description: 'Strong and bold espresso' }
    When method POST
    Then status 200
    And match response == { id: '#number', name: 'Espresso Supremo', description: 'Strong and bold espresso' }
    And match response.id == '#present'
    And match response.name == '#notnull'
    * def coffeeId = response.id
    * print 'Coffee creado con ID:', coffeeId

    # BLOQUE 2: Consulta - usa el ID generado dinámicamente
    * print '========== BLOQUE 2: CONSULTAR COFFEE =========='
    Given path '/api/v1/Coffees/' + coffeeId
    When method GET
    Then status 200
    And match response.id == coffeeId
    And match response.name == 'Espresso Supremo'
    And match response.description == 'Strong and bold espresso'
    And match response == { id: '#number', name: '#string', description: '#string' }
    * print 'Coffee consultado correctamente:', response

    # BLOQUE 3: Actualización - usa el ID del bloque 1
    * print '========== BLOQUE 3: ACTUALIZAR COFFEE =========='
    Given path '/api/v1/Coffees'
    And header Content-Type = 'application/json'
    And request { id: '#(coffeeId)', name: 'Espresso Supremo Updated', description: 'Updated bold espresso recipe' }
    When method PUT
    Then status 200
    And match response.id == coffeeId
    And match response.name == 'Espresso Supremo Updated'
    And match response.description == 'Updated bold espresso recipe'
    * print 'Coffee actualizado correctamente:', response

    # Verificar que la actualización persiste
    Given path '/api/v1/Coffees/' + coffeeId
    When method GET
    Then status 200
    And match response.name == 'Espresso Supremo Updated'
    * print 'Persistencia de actualización verificada'

    # BLOQUE 4: Eliminación - usa el ID del bloque 1
    * print '========== BLOQUE 4: ELIMINAR COFFEE =========='
    Given path '/api/v1/Coffees'
    And param id = coffeeId
    When method DELETE
    Then status 200
    * print 'Coffee eliminado con ID:', coffeeId

    # BLOQUE 5: Validación final - recurso eliminado no existe
    * print '========== BLOQUE 5: VALIDAR RECURSO ELIMINADO =========='
    Given path '/api/v1/Coffees/' + coffeeId
    When method GET
    Then status 404
    * print 'Validado: recurso eliminado no existe'

  # Escenarios individuales para validaciones específicas
  Scenario: Crear Coffee valida estructura completa del response
    Given path '/api/v1/Coffees'
    And header Content-Type = 'application/json'
    And request { name: 'Latte Art', description: 'Smooth latte' }
    When method POST
    Then status 200
    And match response == { id: '#number', name: '#string', description: '#string' }
    And match response.id == '#present'
    And match response.id == '#number'
    And match response.name == 'Latte Art'
    * def createdId = response.id

    # Limpiar - eliminar el coffee creado
    Given path '/api/v1/Coffees'
    And param id = createdId
    When method DELETE
    Then status 200

  Scenario: Consultar Coffee inexistente retorna 404
    Given path '/api/v1/Coffees/999999'
    When method GET
    Then status 404