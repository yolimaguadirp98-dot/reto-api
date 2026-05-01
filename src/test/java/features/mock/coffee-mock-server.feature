Feature: Coffee Shop Mock Server

  Background:
    * karate.set('counter', 0)
    * karate.set('coffees', {})

  Scenario: pathMatches('/api/v1/Coffees') && methodIs('post')
    * def body = request
    * def counter = karate.get('counter') + 1
    * eval karate.set('counter', counter)
    * def coffee = { id: 0, name: '', description: '' }
    * eval coffee.id = counter
    * eval coffee.name = body.name
    * eval coffee.description = body.description
    * def coffees = karate.get('coffees')
    * eval coffees[counter] = coffee
    * eval karate.set('coffees', coffees)
    * def response = coffee
    * def responseStatus = 200

  Scenario: pathMatches('/api/v1/Coffees/{id}') && methodIs('get')
    * def id = parseInt(pathParams.id)
    * def coffees = karate.get('coffees')
    * def found = coffees[id]
    * def response = found ? found : { error: 'Coffee not found' }
    * def responseStatus = found ? 200 : 404

  Scenario: pathMatches('/api/v1/Coffees') && methodIs('put')
    * def body = request
    * def id = body.id
    * def coffees = karate.get('coffees')
    * def exists = coffees[id]
    * def responseStatus = exists ? 200 : 404
    * eval if (exists) { exists.name = body.name; exists.description = body.description; coffees[id] = exists; karate.set('coffees', coffees); }
    * def response = exists ? exists : { error: 'Coffee not found' }

  Scenario: pathMatches('/api/v1/Coffees') && methodIs('delete')
    * def id = parseInt(paramValue('id'))
    * def coffees = karate.get('coffees')
    * def exists = coffees[id]
    * def responseStatus = exists ? 200 : 404
    * eval if (exists) { delete coffees[id]; karate.set('coffees', coffees); }
    * def response = exists ? { message: 'Deleted successfully' } : { error: 'Coffee not found' }