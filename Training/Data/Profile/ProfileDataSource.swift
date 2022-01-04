//
//  ProfileDataSource.swift
//  Training
//
//  Created by TimedoorMSI on 01/12/21.
//

import Foundation

struct ProfileDataSource: Codable {
    var genderArray: [String]
    var occupationArray: [String]
    var areaArray: [String]
    var characterArray: [String]
    var hobbyArray: [String]
    
    func genderValue() -> [String]{
        return self.genderArray.map{String(String($0).split(separator: "_")[1])}
    }
    
    func genderLabel() -> [String]{
        return self.genderArray.map{String(String($0).split(separator: "_")[0])}
    }
    
    func genderValue(gender: String?) -> String{
        guard let indexOfLabel = genderLabel().firstIndex(of: gender ?? "") else { return "" }
        return self.genderValue()[indexOfLabel]
    }
    
    func genderLabel(gender: String?) -> String{
        guard let index = genderValue().firstIndex(of: gender ?? "") else { return "" }
        return self.genderLabel()[index]
    }
    

    func occupationValue() -> [String]{
        return self.occupationArray.map{String(String($0).split(separator: "_")[1])}
    }
    
    func occupationLabel() -> [String]{
        return self.occupationArray.map{String(String($0).split(separator: "_")[0])}
    }
    
    func occupationValue(occupation: String?) -> String{
        guard let index = occupationLabel().firstIndex(of: occupation ?? "") else { return "" }
        return occupationValue()[index]
    }
    
    func occupationLabel(occupation: String?) -> String{
        guard let index = occupationValue().firstIndex(of: occupation ?? "") else { return "" }
        return occupationLabel()[index]
    }
    
    func areaValue() -> [String]{
        return self.areaArray.map{String(String($0).split(separator: "_")[1])}
    }
    
    func areaLabel() -> [String]{
        return self.areaArray.map{String(String($0).split(separator: "_")[0])}
    }
    
    func areaValue(area: String?) -> String{
        guard let index = areaLabel().firstIndex(of: area ?? "") else { return "" }
        return areaValue()[index]
    }
    
    func areaLabel(area: String?) -> String{
        guard let index = areaValue().firstIndex(of: area ?? "") else { return "" }
        return areaLabel()[index]
    }
    
    func characterValue() -> [String]{
        return self.characterArray.map{String(String($0).split(separator: "_")[1])}
    }
    
    func characterLabel() -> [String]{
        return self.characterArray.map{String(String($0).split(separator: "_")[0])}
    }
    
    func characterValue(character: String) -> String{
        guard let index = characterLabel().firstIndex(of: character) else { return "" }
        return characterValue()[index]
    }
    
    func characterLabel(character: String) -> String{
        guard let index = characterValue().firstIndex(of: character) else { return "" }
        return characterLabel()[index]
    }
    
    func hobbyValue() -> [String]{
        return self.hobbyArray.map{String(String($0).split(separator: "_")[1])}
    }
    
    func hobbyLabel() -> [String]{
        return self.hobbyArray.map{String(String($0).split(separator: "_")[0])}
    }
    
    func hobbyValue(labels: String) -> String{
        let hobbies = labels.replacingOccurrences(of: " ", with: "", options: NSString.CompareOptions.literal, range:nil)
        let hobbiesLabel = hobbies.components(separatedBy : ",")
        var hobbiesValue : [String] = []
        for label in hobbiesLabel {
            guard let index = hobbyLabel().firstIndex(of: label) else {
                continue
            }
            hobbiesValue.append(hobbyValue()[index])
        }
        return hobbiesValue.joined(separator: ",")
    }

    func hobbyLabel(values: String) -> String{
        let hobbiesValue = values.components(separatedBy: ",")
        var hobbiesLabel: [String] = []
        for value in hobbiesValue {
            guard let index = hobbyValue().firstIndex(of: value) else {
                continue
            }
            hobbiesLabel.append(hobbyLabel()[index])
        }
        return hobbiesLabel.joined(separator: ", ")
    }
}

struct OptionData {
    var id = 0
    var title = ""
}

enum PickerType {
    case Gender
    case Occupation
    case Area
    case Character
}

