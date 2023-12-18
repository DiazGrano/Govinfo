//
//  SplashEntity.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 13/12/23.
//

import Foundation

struct GovFactsResponse: Codable {
    let pagination: Pagination
    let facts: [Fact]
    
    init(pagination: Pagination = Pagination(), facts: [Fact] = []) {
        self.pagination = pagination
        self.facts = facts
    }
    
    enum CodingKeys: String, CodingKey {
        case pagination = "pagination"
        case facts = "results"
    }
}

struct Pagination: Codable {
    let pageSize: Int
    let page: Int
    let total: Int
    
    init(pageSize: Int = 0, page: Int = 0, total: Int = 0) {
        self.pageSize = pageSize
        self.page = page
        self.total = total
    }
}

struct Fact: Codable {
    let id: String
    let dateInsert: String
    let slug: String
    let columns: String
    let fact: String
    let organization: String
    let resource: String
    let url: String
    let operations: String
    let dataset: String
    let createdAt: Int
    
    init(id: String = "", dateInsert: String = "", slug: String = "", columns: String = "", fact: String = "", organization: String = "", resource: String = "", url: String = "", operations: String = "", dataset: String = "", createdAt: Int = 0) {
        self.id = id
        self.dateInsert = dateInsert
        self.slug = slug
        self.columns = columns
        self.fact = fact
        self.organization = organization
        self.resource = resource
        self.url = url
        self.operations = operations
        self.dataset = dataset
        self.createdAt = createdAt
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case dateInsert = "date_insert"
        case slug = "slug"
        case columns = "columns"
        case fact = "fact"
        case organization = "organization"
        case resource = "resource"
        case url = "url"
        case operations = "operations"
        case dataset = "dataset"
        case createdAt = "created_at"
    }
    
    func getDictionary() -> Array<(key: String, value: String)> {
        let dictionary = [CodingKeys.id.rawValue.beautify().replacingOccurrences(of: " ", with: ""): id,
                          CodingKeys.dateInsert.rawValue.beautify(): dateInsert,
                          CodingKeys.slug.rawValue.beautify(): slug,
                          CodingKeys.columns.rawValue.beautify(): columns,
                          CodingKeys.fact.rawValue.beautify(): fact,
                          CodingKeys.organization.rawValue.beautify(): organization,
                          CodingKeys.resource.rawValue.beautify(): resource,
                          CodingKeys.url.rawValue.beautify(): url,
                          CodingKeys.operations.rawValue.beautify(): operations,
                          CodingKeys.dataset.rawValue.beautify(): dataset,
                          CodingKeys.createdAt.rawValue.beautify(): "\(createdAt)"]
        
        let sortedDictionary = dictionary.sorted { a, b in
            return a.key < b.key
        }
        
        return sortedDictionary
    }
}
