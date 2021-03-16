//
//  EventsModel.swift
//  sicredi
//
//  Created by Cleber Reis on 15/03/21.
//

import Foundation

struct EventsModel: Codable {
    let people: [People]
    let date: Int
    let description: String
    let image: String
    let longitude: Double
    let latitude: Double
    let price: Double
    let title: String
    let id: Int
}

struct People: Codable {
    
}

/*
#### - API - ######
 
 A API de eventos está disponivel em:
 http://5f5a8f24d44d640016169133.mockapi.io/api/events

 Para acessar cada detalhe do evento basta adicionar o ID do item ao final da URL. Ex: http://5f5a8f24d44d640016169133.mockapi.io/api/events/1

 Para realizar o check-in faça um POST no seguinte endereço: http://5f5a8f24d44d640016169133.mockapi.io/api/checkin

 O POST deve conter os dados do interessado (Nome, e-mail) e o id do evento. Ex:

 { "eventId": "1", "name": "Otávio", "email": "otavio_souza@..." }
 
 */


HEFF5scul0kest!ax
