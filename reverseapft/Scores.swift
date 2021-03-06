//
//  Scores.swift
//  reverseapft
//
//  Created by Zachary Gorak on 2/19/18.
//  Copyright © 2018 twodayslate. All rights reserved.
//

import Foundation

enum Gender : Int, CustomStringConvertible {
	case male
	case female
	
	static func from(value: String) -> Gender {
		if value.lowercased() == "female" {
			return .female
		}
		return .male
	}
	
	var description: String {
		get {
			switch self {
				case .female: return "FEMALE"
				case .male: return "MALE"
			}
		}
	}
}

class Score {
	public var gender: Gender = .male
	public var age: Int = 22
	
	public init() {
		
	}
	
    public convenience init(age: Int, gender: Gender) {
		self.init()
        self.gender = gender
        self.age = age
	}
	
	static var gender: Gender = .male
	static var age: Int = 22
	
	public static func runScore(minutes: Int, seconds: Int) -> Int {
		return score(forRun: minutes*100+seconds)
	}
	
	public static func index(forAge age: Int) -> Int {
		if age < 22 {
			return 0
		}
		if age < 27 {
			return 1
		}
		if age < 32 {
			return 2
		}
		if age < 37 {
			return 3
		}
		if age < 42 {
			return 4
		}
		if age < 47 {
			return 5
		}
		return 6
	}
	
	static func pushupRequirement(forScore score: Int) -> Int {
		let index = score - 30
		return pushups[Score.gender.rawValue][Score.index(forAge: Score.age)][index]
	}
	
	static func score3(forPushups pushups: Int) -> Int {
		let index = Score.index(forPushups: pushups)
		let rar = Score.pushups[Score.gender.rawValue][Score.index(forAge: Score.age)]
		if rar.count >= index {
			return 100
		}
		return rar[index]
	}
	
	/// this is the array of the number of pushups
	private static let pushupCount =
		[05, 06, 07, 08, 09, 10, 11, 12, 13, 14,
		 15, 16, 17, 18, 19, 20, 21, 22, 23, 24,
		 25, 26, 27, 28, 29, 30, 31, 32, 33, 34,
		 35, 36, 37, 38, 39, 40, 41, 42, 43, 44,
		 45, 46, 47, 48, 49, 50, 51, 52, 53, 54,
		 55, 56, 57, 58, 59, 60, 61, 62, 63, 64,
		 65, 66, 67, 68, 69, 70, 71, 72, 73, 74,
		 75,76, 77]
	
	/// returns the number of pushups required for a given score
	static func pushups(forScore score : Int) -> Int {
		let rar = Score.pushups[Score.gender.rawValue][Score.index(forAge: Score.age)]
		if score <= 0 { return 0 }
		for (i, val) in rar.enumerated() {
			if val >= score {
				return Score.pushupCount[i]
			}
		}
		return Score.pushupCount[rar.count]
	}
	
	/// returns the score for the given number of pushups
	public static func score(forPushups pushups: Int) -> Int {
		let ageRar = Score.pushups[Score.gender.rawValue][Score.index(forAge: Score.age)]
		var index = Score.index(forPushups: pushups)
		if index > ageRar.count-1 {
			index = ageRar.count-1
		}
		//print("scoreForPushups", pushups, Score.index(forPushups: pushups), ageRar, ageRar.count, index)
		return ageRar[index]
		
	}
	
	private static func index(forPushups pushups: Int) -> Int {
		for (i, val) in Score.pushupCount.enumerated() {
			if pushups <= val {
				return i
			}
		}
		return pushupCount.count-1
	}
	
	/// this is the array for a score for the number of pushups based on pushupRar
	private static let pushups = [
		// male
		[
			[ // 17-21 (male) - pushups
			//  05, 06, 07, 08, 09, 10, 11, 12, 13, 14,
				09, 10, 12, 13, 14, 16, 17, 19, 20, 21,
			//  15, 16, 17, 18, 19, 20, 21, 22, 23, 24,
				23, 24, 26, 27, 28, 30, 31, 32, 34, 35,
			//  25, 26, 27, 28, 29, 30, 31, 32, 33, 34,
				37, 38, 39, 41, 42, 43, 45, 46, 48, 49,
			//  35, 36, 37, 38, 39, 40, 41, 42, 43, 44,
				50, 52, 53, 54, 56, 57, 59, 60, 61, 63,
			//  45, 46, 47, 48, 49, 50, 51, 52, 53, 54,
				64, 66, 67, 68, 70, 71, 72, 74, 75, 77,
			//  55, 56, 57, 58, 59, 60, 61, 62, 63, 64,
				78, 79, 81, 82, 83, 85, 86, 88, 89, 90,
			//  65, 66, 67, 68, 69, 70, 71, 72, 73, 74,
				92, 93, 94, 96, 97, 99, 100
			],
			[ // 22-27 (male) - pushups
			//  05, 06, 07, 08, 09, 10, 11, 12, 13, 14,
				20, 21, 22, 23, 25, 26, 27, 28, 29, 30,
			//  15, 16, 17, 18, 19, 20, 21, 22, 23, 24,
				31, 33, 34, 35, 36, 37, 38, 39, 41, 42,
			//  25, 26, 27, 28, 29, 30, 31, 32, 33, 34,
				43, 44, 45, 46, 47, 49, 50, 51, 52, 53,
			//  35, 36, 37, 38, 39, 40, 41, 42, 43, 44,
				54, 55, 57, 58, 59, 60, 61, 62, 63, 65,
			//  45, 46, 47, 48, 49, 50, 51, 52, 53, 54,
				66, 67, 68, 69, 70, 71, 73, 74, 75, 76,
			//  55, 56, 57, 58, 59, 60, 61, 62, 63, 64,
				77, 78, 79, 81, 82, 83, 84, 85, 86, 87,
			//  65, 66, 67, 68, 69, 70, 71, 72, 73, 74,
				89, 90, 91, 92, 93, 94, 95, 97, 98, 99,
			//  75, 76, 77
				100
			],
			[ // 27-31 (male) - pushups
			//  05, 06, 07, 08, 09, 10, 11, 12, 13, 14,
				24, 25, 26, 27, 28, 29, 31, 32, 33, 34,
			//  15, 16, 17, 18, 19, 20, 21, 22, 23, 24,
				35, 36, 37, 38, 39, 40, 41, 42, 43, 44,
			//  25, 26, 27, 28, 29, 30, 31, 32, 33, 34,
				45, 46, 47, 48, 49, 50, 52, 53, 54, 55,
			//  35, 36, 37, 38, 39, 40, 41, 42, 43, 44,
				56, 57, 58, 59, 60, 61, 62, 63, 64, 65,
			//  45, 46, 47, 48, 49, 50, 51, 52, 53, 54,
				66, 67, 68, 69, 71, 72, 73, 74, 75, 76,
			//  55, 56, 57, 58, 59, 60, 61, 62, 63, 64,
				77, 78, 79, 80, 81, 82, 83, 84, 85, 86,
			//  65, 66, 67, 68, 69, 70, 71, 72, 73, 74,
				87, 88, 89, 91, 92, 93, 94, 95, 96, 97,
			//  75, 76, 77
				98, 99, 100
			],
			[ // 32-36 (male) - pushups
			//  05, 06, 07, 08, 09, 10, 11, 12, 13, 14,
				28, 29, 30, 31, 32, 33, 34, 35, 36, 37,
			//  15, 16, 17, 18, 19, 20, 21, 22, 23, 24,
				38, 39, 41, 42, 43, 44, 45, 46, 47, 48,
			//  25, 26, 27, 28, 29, 30, 31, 32, 33, 34,
				49, 50, 51, 52, 53, 54, 55, 56, 57, 58,
			//  35, 36, 37, 38, 39, 40, 41, 42, 43, 44,
				59, 60, 61, 62, 63, 64, 65, 66, 67, 68,
			//  45, 46, 47, 48, 49, 50, 51, 52, 53, 54,
				69, 70, 71, 72, 73, 74, 75, 76, 77, 78,
			//  55, 56, 57, 58, 59, 60, 61, 62, 63, 64,
				79, 81, 82, 83, 84, 85, 86, 87, 88, 89,
			//  65, 66, 67, 68, 69, 70, 71, 72, 73, 74,
				90, 91, 92, 93, 94, 95, 96, 97, 98, 99,
			//  75, 76, 77
				100
			],
			[ // 37- 41
			//  05, 06, 07, 08, 09, 10, 11, 12, 13, 14,
				30, 31, 32, 33, 34, 35, 36, 37, 38, 39,
			//  15, 16, 17, 18, 19, 20, 21, 22, 23, 24,
				41, 42, 43, 44, 45, 46, 47, 48, 49, 50,
			//  25, 26, 27, 28, 29, 30, 31, 32, 33, 34,
				51, 52, 53, 54, 55, 56, 57, 58, 59, 60,
			//  35, 36, 37, 38, 39, 40, 41, 42, 43, 44,
				61, 62, 63, 64, 65, 66, 67, 68, 69, 70,
			//  45, 46, 47, 48, 49, 50, 51, 52, 53, 54,
				71, 72, 73, 74, 75, 76, 77, 78, 79, 81,
			//  55, 56, 57, 58, 59, 60, 61, 62, 63, 64,
				82, 83, 84, 85, 86, 87, 88, 89, 90, 91,
			//  65, 66, 67, 68, 69, 70, 71, 72, 73, 74,
				92, 93, 94, 95, 96, 97, 98, 99, 100
			],
			[ // 42-46
			//  05, 06, 07, 08, 09, 10, 11, 12, 13, 14,
				32, 33, 34, 36, 37, 38, 39, 40, 41, 42,
			//  15, 16, 17, 18, 19, 20, 21, 22, 23, 24,
				43, 44, 46, 47, 48, 49, 50, 51, 52, 53,
			//  25, 26, 27, 28, 29, 30, 31, 32, 33, 34,
				54, 56, 57, 58, 59, 60, 61, 62, 63, 64,
			//  35, 36, 37, 38, 39, 40, 41, 42, 43, 44,
				66, 67, 68, 69, 70, 71, 72, 73, 74, 76,
			//  45, 46, 47, 48, 49, 50, 51, 52, 53, 54,
				77, 78, 79, 80, 81, 82, 83, 84, 86, 87,
			//  55, 56, 57, 58, 59, 60, 61, 62, 63, 64,
				88, 89, 90, 91, 92, 93, 94, 96, 97, 98,
			//  65, 66, 67, 68, 69, 70, 71, 72, 73, 74,
				99, 100
			],
			[ // 47-51
			//  05, 06, 07, 08, 09, 10, 11, 12, 13, 14,
				36, 38, 39, 40, 41, 42, 45, 46, 47, 48,
			//  15, 16, 17, 18, 19, 20, 21, 22, 23, 24,
				49, 50, 51, 52, 53, 54, 55, 56, 58, 59,
			//  25, 26, 27, 28, 29, 30, 31, 32, 33, 34,
				60, 61, 62, 64, 65, 66, 67, 68, 69, 71,
			//  35, 36, 37, 38, 39, 40, 41, 42, 43, 44,
				72, 73, 74, 75, 76, 78, 79, 80, 81, 82,
			//  45, 46, 47, 48, 49, 50, 51, 52, 53, 54,
				85, 86, 87, 88, 89, 90, 91, 92, 93, 94,
			//  55, 56, 57, 58, 59, 60, 61, 62, 63, 64,
				95, 96, 98, 99, 100
			],
			[ // 52+
			//  05, 06, 07, 08, 09, 10, 11, 12, 13, 14,
				43, 44, 46, 47, 48, 49, 50, 51, 52, 53,
			//  15, 16, 17, 18, 19, 20, 21, 22, 23, 24,
				54, 56, 57, 58, 59, 60, 61, 62, 63, 64,
			//  25, 26, 27, 28, 29, 30, 31, 32, 33, 34,
				66, 67, 68, 69, 70, 71, 72, 73, 74, 76,
			//  35, 36, 37, 38, 39, 40, 41, 42, 43, 44,
				77, 78, 79, 80, 81, 82, 83, 84, 86, 87,
			//  45, 46, 47, 48, 49, 50, 51, 52, 53, 54,
				88, 89, 90, 91, 92, 94, 95, 96, 97, 98,
			//  55, 56, 57, 58, 59, 60, 61, 62, 63, 64,
				99, 100
			]
		],
		// female
		[
			[  // >21
			//  05, 06, 07, 08, 09, 10, 11, 12, 13, 14,
				36, 37, 39, 41, 43, 44, 46, 58, 50, 51,
			//  15, 16, 17, 18, 19, 20, 21, 22, 23, 24,
				53, 55, 57, 58, 60, 62, 63, 65, 67, 69,
			//  25, 26, 27, 28, 29, 30, 31, 32, 33, 34,
				70, 72, 74, 76, 77, 79, 81, 83, 84, 86,
			//  45, 46, 47, 48, 49, 50, 51, 52, 53, 54,
				88, 90, 91, 93, 95, 97, 98, 100
			],
			[ // 22-26
			//  05, 06, 07, 08, 09, 10, 11, 12, 13, 14,
				43, 45, 45, 48, 49, 49, 50, 52, 54, 56,
			//  15, 16, 17, 18, 19, 20, 21, 22, 23, 24,
				57, 59, 60, 61, 63, 64, 66, 67, 68, 70,
			//  25, 26, 27, 28, 29, 30, 31, 32, 33, 34,
				71, 72, 74, 75, 77, 78, 79, 81, 82, 83,
			//  45, 46, 47, 48, 49, 50, 51, 52, 53, 54,
				85, 86, 88, 89, 90, 92, 93, 94, 96, 97,
			//  55, 56, 57, 58, 59, 60, 61, 62, 63, 64,
				99, 100
			],
			[ // 27-31
				45, 47, 48, 49, 49, 50, 52, 54, 55, 56,
				58, 59, 60, 61, 62, 64, 65, 66, 67, 68,
				70, 71, 72, 73, 75, 76, 77, 78, 79, 81,
				82, 83, 84, 85, 87, 88, 89, 90, 92, 93,
				94, 95, 96, 98, 99, 100
			],
			[ // 32-36
				47, 48, 49, 49, 50, 52, 54, 58, 58, 59,
				60, 61, 63, 64, 65, 67, 68, 69, 71, 72,
				73, 75, 76, 77, 79, 80, 81, 83, 84, 85,
				87, 88, 89, 91, 92, 93, 95, 96, 97, 99,
				100
			],
			[ // 37-41
				48, 50, 51, 53, 54, 56, 57, 59, 60, 61,
				63, 64, 66, 67, 69, 70, 72, 73, 75, 76,
				78, 79, 81, 82, 84, 85, 87, 88, 90, 91,
				93, 94, 96, 97, 99, 100
			],
			[ // 42-46
				49, 50, 52, 54, 55, 57, 58, 50, 62, 63,
				65, 66, 68, 70, 71, 73, 64, 76, 78, 79,
				81, 82, 84, 86, 87, 89, 90, 92, 94, 95,
				97, 98, 100
			],
			[ // 47-51
				52, 53, 55, 57, 58, 60, 62, 63, 65, 67,
				68, 70, 72, 73, 75, 77, 78, 80, 82, 83,
				85, 87, 88, 90, 92, 93, 95, 97, 98, 100
			],
			[ // 52+
				53, 55, 56, 58, 60, 62, 64, 65, 67, 69,
				71, 73, 75, 76, 78, 80, 82, 84, 85, 87,
				89, 91, 93, 95, 96, 89, 100
			]
		]
	]
	
	/// returns the number of pushups required for a given score
	static func situps(forScore score : Int) -> Int {
		let rar = Score.situps[Score.index(forAge: Score.age)]
		if score <= 0 { return 0 }
		for (i, val) in rar.enumerated() {
			if val >= score {
				return Score.situpCount[i]
			}
		}
		return Score.situpCount[rar.count]
	}
	
	/// returns the score for the given number of pushups
	public static func score(forSitups pushups: Int) -> Int {
		let ageRar = Score.situps[Score.index(forAge: Score.age)]
		var index = Score.index(forSitups: pushups)
		if index > ageRar.count-1 {
			index = ageRar.count-1
		}
		//print("scoreForPushups", pushups, Score.index(forPushups: pushups), ageRar, ageRar.count, index)
		return ageRar[index]
	}
	
	private static func index(forSitups pushups: Int) -> Int {
		for (i, val) in Score.situpCount.enumerated() {
			if pushups <= val {
				return i
			}
		}
		return pushupCount.count-1
	}
	
	
	private static let situpCount = [
			21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
			31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
			41, 42, 43, 44, 45, 46, 47, 48, 49, 50,
			51, 52, 53, 54, 55, 56, 57, 58, 59, 60,
			61, 62, 63, 64, 65, 66, 67, 68, 69, 70,
			71, 72, 73, 74, 75, 76, 77, 78, 79, 80,
			81, 82
	]
	
	private static let situps = [
		[ // 17-21 (male/female) - situps
			09, 10, 12, 14, 15, 17, 18, 20, 22, 23,
			25, 26, 28, 30, 31, 33, 34, 36, 38, 39,
			41, 42, 44, 45, 47, 49, 50, 52, 54, 55,
			57, 58, 60, 62, 63, 65, 66, 68, 70, 71,
			73, 74, 76, 78, 79, 81, 82, 84, 87, 88,
			89, 90, 92, 94, 95, 97, 98, 100
		],
		[ // 22-26 (male/female) - situps
			21, 23, 24, 25, 27, 28, 29, 31, 32, 33,
			35, 36, 37, 39, 40, 41, 43, 44, 45, 47,
			48, 49, 50, 52, 53, 55, 56, 57, 59, 60,
			61, 63, 64, 65, 67, 68, 69, 71, 72, 73,
			75, 76, 77, 79, 80, 81, 83, 84, 85, 87,
			88, 89, 91, 92, 93, 95, 96, 97, 99, 100
		],
		[ // 27-31 (male/female) - situps
			34, 35, 36, 37, 38, 39, 41, 42, 43, 44,
			45, 46, 47, 48, 49, 50, 51, 52, 54, 55,
			56, 57, 58, 59, 60, 61, 62, 63, 64, 65,
			66, 68, 69, 70, 71, 72, 73, 74, 75, 76,
			77, 78, 79, 81, 82, 83, 84, 85, 86, 87,
			88, 89, 90, 91, 92, 94, 95, 96, 97, 98,
			99, 100
		],
		[
			35, 36, 38, 39, 40, 41, 42, 44, 45, 46,
			47, 48, 49, 50, 52, 53, 54, 55, 56, 58,
			59, 60, 61, 62, 64, 65, 66, 67, 68, 69,
			71, 72, 73, 74, 75, 76, 78, 79, 80, 81,
			82, 84, 85, 86, 87, 88, 89, 91, 92, 93,
			94, 95, 96, 98, 99, 100
		],
		[
			42, 43, 44, 45, 46, 47, 48, 49, 50, 52,
			53, 54, 55, 56, 57, 58, 59, 60, 61, 62,
			63, 64, 65, 66, 67, 68, 69, 71, 72, 73,
			74, 75, 76, 77, 78, 79, 80, 81, 82, 83,
			84, 85, 86, 87, 88, 89, 91, 92, 93, 94,
			95, 96, 97, 98, 99, 100
		],
		[
			49, 50, 51, 52, 53, 54, 55, 56, 57, 58,
			59, 60, 61, 62, 63, 64, 65, 66, 67, 68,
			69, 70, 71, 72, 73, 74, 75, 76, 77, 78,
			79, 80, 81, 82, 83, 84, 85, 86, 87, 88,
			89, 90, 91, 92, 93, 94, 95, 96, 97, 98,
			99, 100
		],
		[
			50, 51, 52, 53, 54, 56, 57, 58, 59, 60,
			61, 62, 63, 64, 66, 67, 68, 69, 70, 71,
			72, 73, 74, 76, 77, 78, 79, 80, 81, 82,
			83, 84, 86, 87, 88, 89, 90, 91, 92, 93,
			94, 96, 97, 98, 99, 100
		],
		[
			53, 54, 55, 56, 57, 58, 59, 60, 61, 62,
			63, 64, 65, 66, 67, 68, 69, 71, 72, 73,
			74, 75, 76, 77, 78, 79, 80, 81, 82, 83,
			84, 85, 86, 87, 88, 89, 91, 92, 93, 94,
			95, 96, 97, 98, 99, 100
		]
	]
	
	/// returns the number of pushups required for a given score
	static func runTime(forScore score : Int) -> Int {
		let rar = Score.run[self.gender.rawValue][Score.index(forAge: Score.age)]
        let timeRar = Score.gender == .male ? Score.maleRunCount : Score.femaleRunCount
		if score <= 0 { return 0 }
		for (i, val) in rar.enumerated() {
			if val >= score {
                return timeRar[i]
			}
		}
		return timeRar[timeRar.count]
	}
	
	/// returns the score for the given number of pushups
	public static func score(forRun time: Int) -> Int {
        print("getting score for: ", time)
        let rar = Score.run[self.gender.rawValue][Score.index(forAge: Score.age)]
		let index = max(0, min(Score.index(forRun: time), rar.count-1))
        print(rar, index, rar.count)
		return rar[index]
	}
	
	private static func index(forRun time: Int) -> Int {
		let rar = Score.gender == .male ? Score.maleRunCount : Score.femaleRunCount
        print(rar)
		for (i, val) in rar.enumerated() {
			if time == val {
                print(time, ">=", val, ": ", i)
				return i
			}
            if time > val {
                return i-1
            }
		}
        print("never greater")
		return rar.count-1
	}
	
	private static let maleRunCount = [
				2042, 2036, 2030, 2024, 2018, 2012, 2006,
				2000, 1954, 1948, 1942, 1936, 1930, 1924,
				1918, 1912, 1906, 1900, 1854, 1848, 1842,
				1836, 1830, 1824, 1818, 1812, 1806, 1800,
				1754, 1748, 1742, 1736, 1730, 1724, 1718,
				1712, 1706, 1700, 1654, 1648, 1642, 1636,
				1630, 1624, 1618, 1612, 1606, 1600, 1554,
				1548, 1542, 1536, 1530, 1524, 1518, 1512,
				1506, 1500, 1454, 1448, 1442, 1436, 1430,
				1424, 1418, 1412, 1406, 1400, 1354, 1348,
				1342, 1336, 1330, 1324, 1318, 1312, 1306,
				1300, 1254
	]
	
	private static let femaleRunCount = [
				2042, 2036, 2030, 2024, 2018, 2012, 2006,
				2000, 1954, 1948, 1942, 1936, 1930, 1924,
				1918, 1912, 1906, 1900, 1854, 1848, 1842,
                1836, 1830, 1824, 1818, 1812, 1806, 1800,
                1754, 1748, 1742, 1736, 1730, 1724, 1718,
                1712, 1706, 1700, 1654, 1648, 1642, 1636,
                1630, 1624, 1618, 1612, 1606, 1600, 1554,
                1548, 1542, 1536, 1530
	]
	
	private static let run = [
		[ // male
			[
			//  2042, 2036, 2030, 2024, 2018, 2012, 2006,
				0000, 0000, 0000, 0000, 0000, 0001, 0002,
            //  2000, 1954, 1948, 1942, 1936, 1930, 1924,
				0003, 0005, 0006, 0008, 0009, 0010, 0012,
				0013, 0014, 0017, 0018, 0019, 0020, 0021,
				0023, 0024, 0026, 0027, 0028, 0030, 0031,
				0032, 0034, 0035, 0037, 0038, 0039, 0041,
				0042, 0043, 0045, 0046, 0048, 0049, 0050,
				0052, 0053, 0054, 0056, 0057, 0059, 0060,
				0061, 0063, 0064, 0066, 0067, 0068, 0070,
				0071, 0072, 0074, 0075, 0077, 0078, 0079,
				0081, 0082, 0083, 0085, 0086, 0088, 0089,
            //  1342, 1336, 1330, 1324, 1318, 1312, 1306,
				0090, 0092, 0093, 0094, 0096, 0097, 0099,
				0100
			],
			[
				0014, 0016, 0017, 0018, 0019, 0020, 0021,
				0022, 0023, 0024, 0026, 0027, 0028, 0029,
				0030, 0031, 0032, 0033, 0034, 0036, 0037,
				0038, 0039, 0040, 0041, 0042, 0043, 0044,
				0046, 0047, 0048, 0049, 0050, 0051, 0052,
				0053, 0054, 0056, 0057, 0058, 0059, 0060,
				0061, 0062, 0063, 0064, 0066, 0067, 0068,
				0069, 0070, 0071, 0072, 0073, 0074, 0076,
				0077, 0078, 0079, 0080, 0081, 0082, 0083,
				0084, 0086, 0087, 0088, 0089, 0090, 0091,
				0092, 0093, 0094, 0096, 0097, 0098, 0099,
				00100
			],
			[
				0019, 0020, 0021, 0022, 0023, 0024, 0025,
				0028, 0029, 0030, 0031, 0032, 0033, 0034,
				0035, 0036, 0037, 0038, 0039, 0041, 0042,
				0043, 0044, 0045, 0046, 0047, 0048, 0049,
				0050, 0051, 0052, 0054, 0055, 0056, 0057,
				0058, 0059, 0060, 0061, 0062, 0063, 0064,
				0065, 0066, 0068, 0069, 0070, 0071, 0072,
				0073, 0074, 0075, 0076, 0077, 0078, 0079,
				0081, 0082, 0083, 0084, 0085, 0086, 0087,
				0088, 0089, 0090, 0091, 0092, 0094, 0095,
				0096, 0097, 0098, 0099, 00100
			],
			[
				0033, 0034, 0035, 0035, 0036, 0037, 0038,
				0039, 0040, 0041, 0042, 0043, 0044, 0045,
				0045, 0046, 0047, 0048, 0049, 0050, 0051,
				0052, 0053, 0054, 0055, 0055, 0056, 0057,
				0058, 0059, 0060, 0061, 0062, 0063, 0064,
				0065, 0065, 0066, 0067, 0068, 0069, 0070,
				0071, 0072, 0073, 0074, 0075, 0075, 0076,
				0077, 0078, 0079, 0080, 0081, 0082, 0083,
				0084, 0085, 0085, 0086, 0087, 0088, 0089,
				0090, 0091, 0092, 0093, 0094, 0095, 0095,
				0096, 0097, 0098, 0099, 00100
			],
			[
				0040, 0040, 0041, 0042, 0043, 0044, 0045,
				0046, 0046, 0047, 0048, 0049, 0050, 0051,
				0051, 0052, 0053, 0054, 0055, 0056, 0057,
				0057, 0058, 0059, 0060, 0061, 0062, 0063,
				0063, 0064, 0065, 0066, 0067, 0068, 0069,
				0069, 0070, 0071, 0072, 0073, 0074, 0074,
				0075, 0076, 0077, 0078, 0079, 0080, 0080,
				0081, 0082, 0083, 0084, 0085, 0086, 0086,
				0087, 0088, 0089, 0090, 0091, 0091, 0092,
				0093, 0094, 0095, 0096, 0097, 0097, 0098,
				0099, 00100
			],
			[
				0043, 0043, 0044, 0045, 0046, 0047, 0048,
				0049, 0050, 0050, 0051, 0052, 0053, 0054, 0055, 0056, 0057, 0057, 0058, 0059, 0060, 0061, 0062, 0063, 0063, 0064, 0065, 0066, 0067, 0068, 0069, 0070, 0070, 0071, 0072, 0073, 0074, 0075, 0076, 0077, 0077, 0078, 0079, 0080, 0081, 0082, 0083, 0083, 0084, 0085, 0086, 0087, 0088, 0089, 0089, 0090, 0091, 0092, 0093, 0094, 0095, 0096, 0097, 0097, 0098, 0099, 00100
			],
			[
				0051, 0051, 0052, 0053, 0054, 0055, 0055,
				0056, 0057, 0058, 0058, 0059, 0060, 0061, 0062, 0062, 0063, 0064, 0065, 0065, 0066, 0067, 0068, 0069, 0069, 0070, 0071, 0072, 0073, 0073, 0074, 0075, 0076, 0076, 0077, 0078, 0079, 0080, 0080, 0081, 0082, 0083, 0084, 0084, 0085, 0086, 0087, 0087, 0088, 0089, 0090, 0091, 0091, 0092, 0093, 0094, 0095, 0095, 0096, 0097, 0098, 0098, 0099, 00100
			],
			[
				0053, 0054, 0055, 0055, 0056, 0057, 0058,
				0058, 0059, 0060, 0061, 0062, 0062, 0063, 0064, 0065, 0065, 0066, 0067, 0068, 0069, 0069, 0070, 0071, 0072, 0073, 0073, 0074, 0075, 0076, 0076, 0077, 0078, 0079, 0080, 0080, 0081, 0082, 0083, 0084, 0084, 0085, 0086, 0087, 0087, 0088, 0089, 0090, 0091, 0091, 0092, 0093, 0094, 0095, 0095, 0096, 0097, 0098, 0098, 0099, 00100
			]
		],
		[ // female
			[
				0038, 0039, 0041, 0042, 0043, 0044, 0045,
				0047, 0048, 0049, 0050, 0052, 0053, 0054,
				0055, 0056, 0058, 0059, 0060, 0061, 0062,
				0064, 0065, 0066, 0067, 0068, 0070, 0071,
				0072, 0073, 0075, 0076, 0077, 0078, 0079,
				0081, 0082, 0083, 0084, 0085, 0087, 0088,
				0089, 0090, 0092, 0093, 0094, 0095, 0096, 0098, 0099, 00100
			],
			[
				0049, 0050, 0051, 0052, 0053, 0054, 0055,
				0056, 0057, 0058, 0059, 0060, 0061, 0062, 0063, 0064, 0065, 0066, 0067, 0068, 0069, 0070, 0071, 0072, 0073, 0074, 0075, 0076, 0077, 0078, 0079, 0080, 0081, 0082, 0083, 0084, 0085, 0086, 0087, 0088, 0089, 0090, 0091, 0092, 0093, 0094, 0095, 0096, 0097, 0098, 0099, 00100
			],
			[
				0058, 0059, 0060, 0061, 0062, 0063, 0063, 0064, 0065, 0066, 0067, 0068, 0069, 0069, 0070, 0071, 0072, 0073, 0074, 0074, 0075, 0076, 0077, 0078, 0079, 0080, 0080, 0081, 0082, 0083, 0084, 0085, 0086, 0086, 0087, 0088, 0089, 0090, 0091, 0091, 0092, 0093, 0094, 0095, 0096, 0097, 0097, 0098, 0099, 00100
			],
			[
				0067, 0068, 0068, 0069, 0070, 0070, 0071, 0072, 0072, 0073, 0074, 0074, 0075, 0076, 0077, 0077, 0078, 0079, 0079, 0080, 0081, 0081, 0082, 0083, 0083, 0084, 0085, 0086, 0086, 0087, 0088, 0088, 0089, 0090, 0090, 0091, 0092, 0092, 0093, 0094, 0094, 0095, 0096, 0097, 0097, 0098, 0099, 0099, 00100
			],
			[
				0074, 0075, 0075, 0076, 0077, 0078, 0078, 0079, 0080, 0080, 0081, 0082, 0082, 0083, 0084, 0085, 0085, 0086, 0087, 0087, 0088, 0089, 0089, 0090, 0091, 0092, 0092, 0093, 0094, 0094, 0095, 0096, 0096, 0097, 0098, 0099, 0099, 00100
			],
			[
				0079, 0080, 0080, 0081, 0082, 0082, 0083, 0083, 0084, 0085, 0085, 0086, 0087, 0087, 0088, 0089, 0089, 0090, 0090, 0091, 0092, 0092, 0093, 0094, 0094, 0095, 0096, 0096, 0097, 0097, 0098, 0099, 0099, 00100
			],
			[
				0081, 0081, 0082, 0082, 0083, 0084, 0084, 0085, 0086, 0086, 0087, 0087, 0088, 0089, 0089, 0090, 0091, 0091, 0092, 0092, 0093, 0094, 0094, 0095, 0096, 0096, 0097, 0097, 0098, 0099, 0099, 00100
			],
			[
				0087, 0088, 0089, 0090, 0090, 0091, 0092, 0093, 0093, 0094, 0095, 0096, 0096, 0097, 0098, 0099, 0099, 00100
			]
		]
	]
	
}
