//
//  MobileProvision.swift
//
//
//  Created by Rinat Abidullin on 12.07.2023.
//

import Foundation

public struct MobileProvision: Decodable {
    public var name: String
    public var appIDName: String
    public var platform: [String]
    public var isXcodeManaged: Bool? = false
    public var creationDate: Date
    public var expirationDate: Date
    public var entitlements: Entitlements

    private enum CodingKeys : String, CodingKey {
        case name = "Name"
        case appIDName = "AppIDName"
        case platform = "Platform"
        case isXcodeManaged = "IsXcodeManaged"
        case creationDate = "CreationDate"
        case expirationDate = "ExpirationDate"
        case entitlements = "Entitlements"
    }

    public struct Entitlements: Decodable {
        public let keychainAccessGroups: [String]
        public let getTaskAllow: Bool
        public let apsEnvironment: Environment

        private enum CodingKeys: String, CodingKey {
            case keychainAccessGroups = "keychain-access-groups"
            case getTaskAllow = "get-task-allow"
            case apsEnvironment = "aps-environment"
        }

        public enum Environment: String, Decodable {
            case development, production, disabled
        }

        init(keychainAccessGroups: Array<String>, getTaskAllow: Bool, apsEnvironment: Environment) {
            self.keychainAccessGroups = keychainAccessGroups
            self.getTaskAllow = getTaskAllow
            self.apsEnvironment = apsEnvironment
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let keychainAccessGroups: [String] = (try? container.decode([String].self, forKey: .keychainAccessGroups)) ?? []
            let getTaskAllow: Bool = (try? container.decode(Bool.self, forKey: .getTaskAllow)) ?? false
            let apsEnvironment: Environment = (try? container.decode(Environment.self, forKey: .apsEnvironment)) ?? .disabled

            self.init(keychainAccessGroups: keychainAccessGroups, getTaskAllow: getTaskAllow, apsEnvironment: apsEnvironment)
        }
    }
}

public extension MobileProvision {
    /// Считывает embedded.mobileprovision
    static func read() -> MobileProvision? {
        let profilePath: String? = Bundle.main.path(
            forResource: "embedded",
            ofType: "mobileprovision"
        )
        guard let path = profilePath else { return nil }
        return read(at: path)
    }

    /// Считывает произвольный mobileprovision-файл по указанному пути
    static func read(at profilePath: String) -> MobileProvision? {
        guard let plistDataString = try? String(
            contentsOfFile: profilePath,
            encoding: .isoLatin1
        ) else {
            return nil
        }

        let scanner = Scanner(string: plistDataString as String)
        guard scanner.scanUpToString("<plist") != nil else { return nil }
        guard let extractedPlist = scanner.scanUpToString("</plist>") else { return nil }
        guard let plist = extractedPlist.appending("</plist>").data(using: .isoLatin1) else { return nil }

        let decoder = PropertyListDecoder()
        do {
            let provision = try decoder.decode(MobileProvision.self, from: plist)
            return provision
        } catch {
            return nil
        }
    }
}
