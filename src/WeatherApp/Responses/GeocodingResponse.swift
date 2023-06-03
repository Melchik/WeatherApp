//
//  GeocodingResponse.swift
//  WeatherApp
//
//  Created by Илья Поздняков on 03.06.2023.
//

// swiftlint:disable type_contents_order identifier_name redundant_string_enum_value

import Foundation

public typealias GeocodingResponse = [GeocodingElement]

public struct GeocodingElement: Codable, Equatable {
    public let name: String?
    public let localNames: LocalNames?
    public let lat: Double?
    public let lon: Double?
    public let country: String?
    public let state: String?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case localNames = "local_names"
        case lat = "lat"
        case lon = "lon"
        case country = "country"
        case state = "state"
    }

    public init(
        name: String?,
        localNames: LocalNames?,
        lat: Double?,
        lon: Double?,
        country: String?,
        state: String?
    ) {
        self.name = name
        self.localNames = localNames
        self.lat = lat
        self.lon = lon
        self.country = country
        self.state = state
    }
}

public struct LocalNames: Codable, Equatable {
    public let hy: String?
    public let de: String?
    public let pl: String?
    public let hr: String?
    public let sr: String?
    public let ca: String?
    public let ko: String?
    public let ar: String?
    public let lt: String?
    public let ka: String?
    public let ro: String?
    public let ru: String?
    public let be: String?
    public let sk: String?
    public let fi: String?
    public let uk: String?
    public let fr: String?
    public let hu: String?
    public let nl: String?
    public let en: String?
    public let et: String?

    enum CodingKeys: String, CodingKey {
        case hy = "hy"
        case de = "de"
        case pl = "pl"
        case hr = "hr"
        case sr = "sr"
        case ca = "ca"
        case ko = "ko"
        case ar = "ar"
        case lt = "lt"
        case ka = "ka"
        case ro = "ro"
        case ru = "ru"
        case be = "be"
        case sk = "sk"
        case fi = "fi"
        case uk = "uk"
        case fr = "fr"
        case hu = "hu"
        case nl = "nl"
        case en = "en"
        case et = "et"
    }

    public init(
        hy: String?,
        de: String?,
        pl: String?,
        hr: String?,
        sr: String?,
        ca: String?,
        ko: String?,
        ar: String?,
        lt: String?,
        ka: String?,
        ro: String?,
        ru: String?,
        be: String?,
        sk: String?,
        fi: String?,
        uk: String?,
        fr: String?,
        hu: String?,
        nl: String?,
        en: String?,
        et: String?
    ) {
        self.hy = hy
        self.de = de
        self.pl = pl
        self.hr = hr
        self.sr = sr
        self.ca = ca
        self.ko = ko
        self.ar = ar
        self.lt = lt
        self.ka = ka
        self.ro = ro
        self.ru = ru
        self.be = be
        self.sk = sk
        self.fi = fi
        self.uk = uk
        self.fr = fr
        self.hu = hu
        self.nl = nl
        self.en = en
        self.et = et
    }
}
