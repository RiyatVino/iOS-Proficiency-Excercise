
import Foundation
struct MainModel : Codable {
	let title : String?
	let rows : [RowsModel]?

	enum CodingKeys: String, CodingKey {

		case title = "title"
		case rows = "rows"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		rows = try values.decodeIfPresent([RowsModel].self, forKey: .rows)
	}

}
