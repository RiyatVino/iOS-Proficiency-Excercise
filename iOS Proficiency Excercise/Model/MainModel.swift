import Foundation
struct MainModel : Codable {
	let titleValue : String?
	let rowsValue : [RowsModel]?

	enum CodingKeys: String, CodingKey {

		case titleValue = "title"
		case rowsValue = "rows"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		titleValue = try values.decodeIfPresent(String.self, forKey: .titleValue)
		rowsValue = try values.decodeIfPresent([RowsModel].self, forKey: .rowsValue)
	}

}
