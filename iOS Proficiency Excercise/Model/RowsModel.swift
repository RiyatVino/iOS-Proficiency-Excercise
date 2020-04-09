import Foundation
struct RowsModel : Codable {
	let titleValue : String?
	let descriptionValue : String?
	let imageHrefValue : String?

	enum CodingKeys: String, CodingKey {

		case titleValue = "title"
		case descriptionValue = "description"
		case imageHrefValue = "imageHref"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		titleValue = try values.decodeIfPresent(String.self, forKey: .titleValue)
		descriptionValue = try values.decodeIfPresent(String.self, forKey: .descriptionValue)
		imageHrefValue = try values.decodeIfPresent(String.self, forKey: .imageHrefValue)
	}

}
