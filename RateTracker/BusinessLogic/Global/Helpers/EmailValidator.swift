//
//  EmailValidator.swift
//  EmailValidator
//
//  Created by Evan Robertson on 27/11/17.
//  Copyright © 2017 Evan Robertson. All rights reserved.
//

import Foundation

struct EmailValidator {

    struct SubDomainType: OptionSet {
        let rawValue: Int

        static let alphabetic = SubDomainType(rawValue: 1 << 0)
        static let numeric = SubDomainType(rawValue: 1 << 1)
        static let alphaNumeric = SubDomainType(rawValue: 1 << 2)
    }

    static let atomCharacterSet = CharacterSet(charactersIn: EmailValidator.atomCharacters)
    static let atomCharacters: String = "!#$%&'*+-/=?^_`{|}~"
    static let hexCharacterSet = CharacterSet(charactersIn: EmailValidator.hexCharacters)
    static let hexCharacters: String = "abcdefABCDEF1234567890"

    private static func isDigit(c: Character) -> Bool {
        for scalar in c.unicodeScalars {
            if !CharacterSet.decimalDigits.contains(scalar) { return false }
        }
        return true
    }

    private static func isLetter(c: Character) -> Bool {
        for scalar in c.unicodeScalars {
            if !CharacterSet.letters.contains(scalar) { return false }
        }
        return true
    }

    private static func isLetterOrDigit(c: Character) -> Bool {
        return (isDigit(c: c) || isLetter(c: c))
    }

    private static func isAtom(c: Character, allowInternational: Bool) -> Bool {
        return c.unicodeScalarCodePoint() < 128 ?
            isLetterOrDigit(c: c) || atomCharacters.contains(c)
            : allowInternational
    }

    private static func isDomain(c: Character, allowInternational: Bool, type: inout SubDomainType) -> Bool {
        if c.unicodeScalarCodePoint() < 128 {
            if isLetter(c: c) || c == "-" {
                type.insert(.alphabetic)
                return true
            }

            if isDigit(c: c) {
                type.insert(.numeric)
                return true
            }

            return false
        }

        if allowInternational {
            type.insert(.alphabetic)
            return true
        }

        return false
    }

    private static func isDomainStart(c: Character, allowInternational: Bool, type: inout SubDomainType) -> Bool {
        if c.unicodeScalarCodePoint() < 128 {
            if isLetter(c: c) {
                type = .alphabetic
                return true
            }

            if isDigit(c: c) {
                type = .numeric
                return true
            }

            type = []

            return false
        }

        if allowInternational {
            type = .alphabetic
            return true
        }

        type = []

        return false
    }

    private static func skipAtom(text: String, index: inout String.Index, allowInternational: Bool) -> Bool {
        let startIndex = index

        while index < text.endIndex && isAtom(c: text[index], allowInternational: allowInternational) {
            index = text.index(after: index)
        }

        return index > startIndex
    }

    private static func skipSubDomain(
        text: String,
        index: inout String.Index,
        allowInternational: Bool,
        type: inout SubDomainType
        ) -> Bool {
        let startIndex = index

        if !isDomainStart(c: text[index], allowInternational: allowInternational, type: &type) {
            return false
        }

        index = text.index(after: index)

        while index < text.endIndex && isDomain(c: text[index], allowInternational: allowInternational, type: &type) {
            index = text.index(after: index)
        }

        let previousIndex = text.index(before: index)
        let offsetIndex = text.index(index, offsetBy: -startIndex.encodedOffset)
        return offsetIndex.encodedOffset < 64 && text[previousIndex] != "-"
    }

    private static func skipDomain(
        text: String,
        index: inout String.Index,
        allowTopLevelDomains: Bool,
        allowInternational: Bool
        ) -> Bool {
        var type: SubDomainType = []

        if !skipSubDomain(text: text, index: &index, allowInternational: allowInternational, type: &type) {
            return false
        }

        if index < text.endIndex && text[index] == "." {
            repeat {
                index = text.index(after: index)

                if index == text.endIndex {
                    return false
                }

                if !skipSubDomain(text: text, index: &index, allowInternational: allowInternational, type: &type) {
                    return false
                }
            } while index < text.endIndex && text[index] == "."
        } else if !allowTopLevelDomains {
            return false
        }

        if type == .numeric {
            return false
        }

        return true
    }

    private static func skipQuoted(text: String, index: inout String.Index, allowInternational: Bool) -> Bool {
        var escaped = false

        // Skip over leading "
        index = text.index(after: index)

        while index < text.endIndex {
            if text[index].unicodeScalarCodePoint() >= 128 && !allowInternational {
                return false
            }

            if text[index] == "\\" {
                escaped = !escaped
            } else if !escaped {
                if text[index] == "\"" { break }
            } else {
                escaped = false
            }

            index = text.index(after: index)
        }

        if index >= text.endIndex || text[index] != "\"" {
            return false
        }

        index = text.index(after: index)

        return true
    }

    private static func skipIPv4Literal(text: String, index: inout String.Index) -> Bool {
        var groups = 0

        while index < text.endIndex && groups < 4 {
            let startIndex = index
            var value = 0

            while index < text.endIndex && isDigit(c: text[index]) {
                value = (value * 10) + (Int("\(text[index])") ?? 0)
                index = text.index(after: index)
            }

            if index == startIndex ||
                text.index(index, offsetBy: -startIndex.encodedOffset).encodedOffset > 3 ||
                value > 255 {
                return false
            }

            groups += 1

            if groups < 4 && index < text.endIndex && text[index] == "." {
                index = text.index(after: index)
            }
        }

        return groups == 4
    }

    private static func isHexDigit(c: Character) -> Bool {
        for scalar in c.unicodeScalars {
            if !hexCharacterSet.contains(scalar) { return false }
        }
        return true
    }

    // swiftlint:disable cyclomatic_complexity
    // swiftlint:disable function_body_length

    /// Check whether the given email is a valid address based on rfc5322 & rfc653x
    /// - Parameters:
    ///     - email: The email address to test
    ///     - allowTopLevelDomains: Allow top level domains (e.g. `postmaster@dk`)
    ///     - allowInternational: Allow international addresses (e.g. cyrillic or chinese)
    /// - Returns: Bool indicating whether the email is valid or not
    static func validate(
        email: String,
        allowTopLevelDomains: Bool = false,
        allowInternational: Bool = false
        ) -> Bool {
        if email.isEmpty || email.endIndex.encodedOffset >= 255 { return false }

        var index = email.startIndex

        if email[index] == "\"" {
            if !skipQuoted(
                text: email,
                index: &index,
                allowInternational: allowInternational
                ) ||
                index >= email.endIndex { return false }
        } else {
            if !skipAtom(
                text: email,
                index: &index,
                allowInternational: allowInternational
                ) ||
                index >= email.endIndex {
                return false
            }

            while email[index] == "." {
                index = email.index(after: index)

                if index >= email.endIndex { return false }

                if !skipAtom(text: email, index: &index, allowInternational: allowInternational) { return false }

                if index >= email.endIndex { return false }
            }
        }

        let nextIndex = email.index(after: index)
        if nextIndex >= email.endIndex || index.encodedOffset > 64 || email[index] != "@" {
            return false
        }

        index = nextIndex

        if email[index] != "[" {
            if !skipDomain(
                text: email,
                index: &index,
                allowTopLevelDomains: allowTopLevelDomains,
                allowInternational: allowInternational
                ) { return false }

            return index == email.endIndex
        }

        index = email.index(after: index)

        if email.index(index, offsetBy: 8) >= email.endIndex {
            return false
        }

        let ipv6 = email[index ... email.index(index, offsetBy: 4)]
        if ipv6.lowercased() == "ipv6:" {
            return false
        }

        if index >= email.endIndex || email[index] != "]" {
            return false
        }

        index = email.index(after: index)

        return index == email.endIndex
    }
}

// swiftlint:enable cyclomatic_complexity
// swiftlint:enable function_body_length

extension Character {
    /// Will return the UInt32 unicode value for first scalar in Character
    /// Returns: UInt32 value of unicode character
    func unicodeScalarCodePoint() -> UInt32 {
        return unicodeScalars.first!.value
    }
}
