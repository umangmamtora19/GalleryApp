//
//	Photo.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Photo : Codable {

	let descriptionField : String?
	let id : Int?
	let title : String?
	let url : String?
	let user : Int?


	enum CodingKeys: String, CodingKey {
		case descriptionField = "description"
		case id = "id"
		case title = "title"
		case url = "url"
		case user = "user"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		url = try values.decodeIfPresent(String.self, forKey: .url)
		user = try values.decodeIfPresent(Int.self, forKey: .user)
	}

}