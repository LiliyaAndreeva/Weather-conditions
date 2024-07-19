//
//  Extention + String.swift
//  Weather conditions
//
//  Created by Лилия Андреева on 17.07.2024.
//

import Foundation
extension String {
	func localized() -> String {
		NSLocalizedString(
			self,
			tableName: "Localizable",
			bundle: .main,
			value: self,
			comment: self
		)
	}
}
