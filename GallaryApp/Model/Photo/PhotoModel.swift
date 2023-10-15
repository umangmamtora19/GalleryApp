//
//	PhotoModel.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct PhotoModel : Codable {

	let limit : Int?
	let message : String?
	let offset : Int?
	let photos : [Photo]?
	let success : Bool?
	let totalPhotos : Int?


	enum CodingKeys: String, CodingKey {
		case limit = "limit"
		case message = "message"
		case offset = "offset"
		case photos = "photos"
		case success = "success"
		case totalPhotos = "total_photos"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		limit = try values.decodeIfPresent(Int.self, forKey: .limit)
		message = try values.decodeIfPresent(String.self, forKey: .message)
		offset = try values.decodeIfPresent(Int.self, forKey: .offset)
		photos = try values.decodeIfPresent([Photo].self, forKey: .photos)
		success = try values.decodeIfPresent(Bool.self, forKey: .success)
		totalPhotos = try values.decodeIfPresent(Int.self, forKey: .totalPhotos)
	}

}