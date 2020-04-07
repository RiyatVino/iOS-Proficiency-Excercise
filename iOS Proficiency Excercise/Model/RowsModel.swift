
import Foundation
struct RowsModel : Codable {
	let title : String?
	let description : String?
	let imageHref : String?

	enum CodingKeys: String, CodingKey {

		case title = "title"
		case description = "description"
		case imageHref = "imageHref"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		imageHref = try values.decodeIfPresent(String.self, forKey: .imageHref)
	}

}
