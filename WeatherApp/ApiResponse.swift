//
//  ApiResponse.swift
//  WeatherApp
//
//  Created by Айсен Еремеев on 04.04.2023.
//

import Foundation
import UIKit

struct ApiResponse: Codable {
    var cities: [WeatherData]?
}

struct WeatherData: Codable {

  var now       : Int?         = nil
  var nowDt     : String?      = nil
  var info      : Info?        = Info()
  var geoObject : GeoObject?   = GeoObject()
  var yesterday : Yesterday?   = Yesterday()
  var fact      : Fact?        = Fact()
  var forecasts : [Forecasts]? = []

  enum CodingKeys: String, CodingKey {

    case now       = "now"
    case nowDt     = "now_dt"
    case info      = "info"
    case geoObject = "geo_object"
    case yesterday = "yesterday"
    case fact      = "fact"
    case forecasts = "forecasts"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    now       = try values.decodeIfPresent(Int.self         , forKey: .now       )
    nowDt     = try values.decodeIfPresent(String.self      , forKey: .nowDt     )
    info      = try values.decodeIfPresent(Info.self        , forKey: .info      )
    geoObject = try values.decodeIfPresent(GeoObject.self   , forKey: .geoObject )
    yesterday = try values.decodeIfPresent(Yesterday.self   , forKey: .yesterday )
    fact      = try values.decodeIfPresent(Fact.self        , forKey: .fact      )
    forecasts = try values.decodeIfPresent([Forecasts].self , forKey: .forecasts )
 
  }

  init() {

  }

}

struct Tzinfo: Codable {

  var name   : String? = nil
  var abbr   : String? = nil
  var dst    : Bool?   = nil
  var offset : Int?    = nil

  enum CodingKeys: String, CodingKey {

    case name   = "name"
    case abbr   = "abbr"
    case dst    = "dst"
    case offset = "offset"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    name   = try values.decodeIfPresent(String.self , forKey: .name   )
    abbr   = try values.decodeIfPresent(String.self , forKey: .abbr   )
    dst    = try values.decodeIfPresent(Bool.self   , forKey: .dst    )
    offset = try values.decodeIfPresent(Int.self    , forKey: .offset )
 
  }

  init() {

  }

}

struct Info: Codable {

  var n             : Bool?   = nil
  var geoid         : Int?    = nil
  var url           : String? = nil
  var lat           : Double? = nil
  var lon           : Double? = nil
  var tzinfo        : Tzinfo? = Tzinfo()
  var defPressureMm : Int?    = nil
  var defPressurePa : Int?    = nil
  var slug          : String? = nil
  var zoom          : Int?    = nil
  var nr            : Bool?   = nil
  var ns            : Bool?   = nil
  var nsr           : Bool?   = nil
  var p             : Bool?   = nil
  var f             : Bool?   = nil
  var H             : Bool?   = nil

  enum CodingKeys: String, CodingKey {

    case n             = "n"
    case geoid         = "geoid"
    case url           = "url"
    case lat           = "lat"
    case lon           = "lon"
    case tzinfo        = "tzinfo"
    case defPressureMm = "def_pressure_mm"
    case defPressurePa = "def_pressure_pa"
    case slug          = "slug"
    case zoom          = "zoom"
    case nr            = "nr"
    case ns            = "ns"
    case nsr           = "nsr"
    case p             = "p"
    case f             = "f"
    case H             = "_h"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    n             = try values.decodeIfPresent(Bool.self   , forKey: .n             )
    geoid         = try values.decodeIfPresent(Int.self    , forKey: .geoid         )
    url           = try values.decodeIfPresent(String.self , forKey: .url           )
    lat           = try values.decodeIfPresent(Double.self , forKey: .lat           )
    lon           = try values.decodeIfPresent(Double.self , forKey: .lon           )
    tzinfo        = try values.decodeIfPresent(Tzinfo.self , forKey: .tzinfo        )
    defPressureMm = try values.decodeIfPresent(Int.self    , forKey: .defPressureMm )
    defPressurePa = try values.decodeIfPresent(Int.self    , forKey: .defPressurePa )
    slug          = try values.decodeIfPresent(String.self , forKey: .slug          )
    zoom          = try values.decodeIfPresent(Int.self    , forKey: .zoom          )
    nr            = try values.decodeIfPresent(Bool.self   , forKey: .nr            )
    ns            = try values.decodeIfPresent(Bool.self   , forKey: .ns            )
    nsr           = try values.decodeIfPresent(Bool.self   , forKey: .nsr           )
    p             = try values.decodeIfPresent(Bool.self   , forKey: .p             )
    f             = try values.decodeIfPresent(Bool.self   , forKey: .f             )
    H             = try values.decodeIfPresent(Bool.self   , forKey: .H             )
 
  }

  init() {

  }

}

struct District: Codable {

  var id   : Int?    = nil
  var name : String? = nil

  enum CodingKeys: String, CodingKey {

    case id   = "id"
    case name = "name"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    id   = try values.decodeIfPresent(Int.self    , forKey: .id   )
    name = try values.decodeIfPresent(String.self , forKey: .name )
 
  }

  init() {

  }

}

struct Locality: Codable {

  var id   : Int?    = nil
  var name : String? = nil

  enum CodingKeys: String, CodingKey {

    case id   = "id"
    case name = "name"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    id   = try values.decodeIfPresent(Int.self    , forKey: .id   )
    name = try values.decodeIfPresent(String.self , forKey: .name )
 
  }

  init() {

  }

}

struct Province: Codable {

  var id   : Int?    = nil
  var name : String? = nil

  enum CodingKeys: String, CodingKey {

    case id   = "id"
    case name = "name"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    id   = try values.decodeIfPresent(Int.self    , forKey: .id   )
    name = try values.decodeIfPresent(String.self , forKey: .name )
 
  }

  init() {

  }

}

struct Country: Codable {

  var id   : Int?    = nil
  var name : String? = nil

  enum CodingKeys: String, CodingKey {

    case id   = "id"
    case name = "name"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    id   = try values.decodeIfPresent(Int.self    , forKey: .id   )
    name = try values.decodeIfPresent(String.self , forKey: .name )
 
  }

  init() {

  }
}

struct GeoObject: Codable {

  var district : District? = District()
  var locality : Locality? = Locality()
  var province : Province? = Province()
  var country  : Country?  = Country()

  enum CodingKeys: String, CodingKey {

    case district = "district"
    case locality = "locality"
    case province = "province"
    case country  = "country"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    district = try values.decodeIfPresent(District.self , forKey: .district )
    locality = try values.decodeIfPresent(Locality.self , forKey: .locality )
    province = try values.decodeIfPresent(Province.self , forKey: .province )
    country  = try values.decodeIfPresent(Country.self  , forKey: .country  )
 
  }

  init() {

  }

}

struct Yesterday: Codable {

  var temp : Int? = nil

  enum CodingKeys: String, CodingKey {

    case temp = "temp"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    temp = try values.decodeIfPresent(Int.self , forKey: .temp )
 
  }

  init() {

  }

}

struct Fact: Codable {

  var obsTime      : Int?       = nil
  var uptime       : Int?       = nil
  var temp         : Int?       = nil
  var feelsLike    : Int?       = nil
  var icon         : String?    = nil
  var condition    : String?    = nil
  var cloudness    : Double?    = nil
  var precType     : Int?       = nil
  var precProb     : Int?       = nil
  var precStrength : Int?       = nil
  var isThunder    : Bool?      = nil
  var windSpeed    : Double?    = nil
  var windDir      : String?    = nil
  var pressureMm   : Int?       = nil
  var pressurePa   : Int?       = nil
  var humidity     : Int?       = nil
  var daytime      : String?    = nil
  var polar        : Bool?      = nil
  var season       : String?    = nil
  var source       : String?    = nil
  var soilMoisture : Double?    = nil
  var soilTemp     : Int?       = nil
  var uvIndex      : Int?       = nil
  var windGust     : Double?    = nil

  enum CodingKeys: String, CodingKey {

    case obsTime      = "obs_time"
    case uptime       = "uptime"
    case temp         = "temp"
    case feelsLike    = "feels_like"
    case icon         = "icon"
    case condition    = "condition"
    case cloudness    = "cloudness"
    case precType     = "prec_type"
    case precProb     = "prec_prob"
    case precStrength = "prec_strength"
    case isThunder    = "is_thunder"
    case windSpeed    = "wind_speed"
    case windDir      = "wind_dir"
    case pressureMm   = "pressure_mm"
    case pressurePa   = "pressure_pa"
    case humidity     = "humidity"
    case daytime      = "daytime"
    case polar        = "polar"
    case season       = "season"
    case source       = "source"
    case soilMoisture = "soil_moisture"
    case soilTemp     = "soil_temp"
    case uvIndex      = "uv_index"
    case windGust     = "wind_gust"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    obsTime      = try values.decodeIfPresent(Int.self       , forKey: .obsTime      )
    uptime       = try values.decodeIfPresent(Int.self       , forKey: .uptime       )
    temp         = try values.decodeIfPresent(Int.self       , forKey: .temp         )
    feelsLike    = try values.decodeIfPresent(Int.self       , forKey: .feelsLike    )
    icon         = try values.decodeIfPresent(String.self    , forKey: .icon         )
    condition    = try values.decodeIfPresent(String.self    , forKey: .condition    )
    cloudness    = try values.decodeIfPresent(Double.self    , forKey: .cloudness    )
    precType     = try values.decodeIfPresent(Int.self       , forKey: .precType     )
    precProb     = try values.decodeIfPresent(Int.self       , forKey: .precProb     )
    precStrength = try values.decodeIfPresent(Int.self       , forKey: .precStrength )
    isThunder    = try values.decodeIfPresent(Bool.self      , forKey: .isThunder    )
    windSpeed    = try values.decodeIfPresent(Double.self    , forKey: .windSpeed    )
    windDir      = try values.decodeIfPresent(String.self    , forKey: .windDir      )
    pressureMm   = try values.decodeIfPresent(Int.self       , forKey: .pressureMm   )
    pressurePa   = try values.decodeIfPresent(Int.self       , forKey: .pressurePa   )
    humidity     = try values.decodeIfPresent(Int.self       , forKey: .humidity     )
    daytime      = try values.decodeIfPresent(String.self    , forKey: .daytime      )
    polar        = try values.decodeIfPresent(Bool.self      , forKey: .polar        )
    season       = try values.decodeIfPresent(String.self    , forKey: .season       )
    source       = try values.decodeIfPresent(String.self    , forKey: .source       )
    soilMoisture = try values.decodeIfPresent(Double.self    , forKey: .soilMoisture )
    soilTemp     = try values.decodeIfPresent(Int.self       , forKey: .soilTemp     )
    uvIndex      = try values.decodeIfPresent(Int.self       , forKey: .uvIndex      )
    windGust     = try values.decodeIfPresent(Double.self    , forKey: .windGust     )
 
  }

  init() {

  }

}

struct Day: Codable {

  var Source       : String? = nil
  var tempMin      : Int?    = nil
  var tempAvg      : Int?    = nil
  var tempMax      : Int?    = nil
  var windSpeed    : Double? = nil
  var windGust     : Double? = nil
  var windDir      : String? = nil
  var pressureMm   : Int?    = nil
  var pressurePa   : Int?    = nil
  var humidity     : Int?    = nil
  var soilTemp     : Int?    = nil
  var soilMoisture : Double? = nil
  var precMm       : Int?    = nil
  var precProb     : Int?    = nil
  var precPeriod   : Int?    = nil
  var cloudness    : Double? = nil
  var precType     : Int?    = nil
  var precStrength : Int?    = nil
  var icon         : String? = nil
  var condition    : String? = nil
  var uvIndex      : Int?    = nil
  var feelsLike    : Int?    = nil
  var daytime      : String? = nil
  var polar        : Bool?   = nil
  var freshSnowMm  : Int?    = nil

  enum CodingKeys: String, CodingKey {

    case Source       = "_source"
    case tempMin      = "temp_min"
    case tempAvg      = "temp_avg"
    case tempMax      = "temp_max"
    case windSpeed    = "wind_speed"
    case windGust     = "wind_gust"
    case windDir      = "wind_dir"
    case pressureMm   = "pressure_mm"
    case pressurePa   = "pressure_pa"
    case humidity     = "humidity"
    case soilTemp     = "soil_temp"
    case soilMoisture = "soil_moisture"
    case precMm       = "prec_mm"
    case precProb     = "prec_prob"
    case precPeriod   = "prec_period"
    case cloudness    = "cloudness"
    case precType     = "prec_type"
    case precStrength = "prec_strength"
    case icon         = "icon"
    case condition    = "condition"
    case uvIndex      = "uv_index"
    case feelsLike    = "feels_like"
    case daytime      = "daytime"
    case polar        = "polar"
    case freshSnowMm  = "fresh_snow_mm"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    Source       = try values.decodeIfPresent(String.self , forKey: .Source       )
    tempMin      = try values.decodeIfPresent(Int.self    , forKey: .tempMin      )
    tempAvg      = try values.decodeIfPresent(Int.self    , forKey: .tempAvg      )
    tempMax      = try values.decodeIfPresent(Int.self    , forKey: .tempMax      )
    windSpeed    = try values.decodeIfPresent(Double.self , forKey: .windSpeed    )
    windGust     = try values.decodeIfPresent(Double.self , forKey: .windGust     )
    windDir      = try values.decodeIfPresent(String.self , forKey: .windDir      )
    pressureMm   = try values.decodeIfPresent(Int.self    , forKey: .pressureMm   )
    pressurePa   = try values.decodeIfPresent(Int.self    , forKey: .pressurePa   )
    humidity     = try values.decodeIfPresent(Int.self    , forKey: .humidity     )
    soilTemp     = try values.decodeIfPresent(Int.self    , forKey: .soilTemp     )
    soilMoisture = try values.decodeIfPresent(Double.self , forKey: .soilMoisture )
    precMm       = try values.decodeIfPresent(Int.self    , forKey: .precMm       )
    precProb     = try values.decodeIfPresent(Int.self    , forKey: .precProb     )
    precPeriod   = try values.decodeIfPresent(Int.self    , forKey: .precPeriod   )
    cloudness    = try values.decodeIfPresent(Double.self , forKey: .cloudness    )
    precType     = try values.decodeIfPresent(Int.self    , forKey: .precType     )
    precStrength = try values.decodeIfPresent(Int.self    , forKey: .precStrength )
    icon         = try values.decodeIfPresent(String.self , forKey: .icon         )
    condition    = try values.decodeIfPresent(String.self , forKey: .condition    )
    uvIndex      = try values.decodeIfPresent(Int.self    , forKey: .uvIndex      )
    feelsLike    = try values.decodeIfPresent(Int.self    , forKey: .feelsLike    )
    daytime      = try values.decodeIfPresent(String.self , forKey: .daytime      )
    polar        = try values.decodeIfPresent(Bool.self   , forKey: .polar        )
    freshSnowMm  = try values.decodeIfPresent(Int.self    , forKey: .freshSnowMm  )
 
  }

  init() {

  }

}

struct Evening: Codable {

  var Source       : String? = nil
  var tempMin      : Int?    = nil
  var tempAvg      : Int?    = nil
  var tempMax      : Int?    = nil
  var windSpeed    : Double? = nil
  var windGust     : Double? = nil
  var windDir      : String? = nil
  var pressureMm   : Int?    = nil
  var pressurePa   : Int?    = nil
  var humidity     : Int?    = nil
  var soilTemp     : Int?    = nil
  var soilMoisture : Double? = nil
  var precMm       : Int?    = nil
  var precProb     : Int?    = nil
  var precPeriod   : Int?    = nil
  var cloudness    : Double? = nil
  var precType     : Int?    = nil
  var precStrength : Int?    = nil
  var icon         : String? = nil
  var condition    : String? = nil
  var uvIndex      : Int?    = nil
  var feelsLike    : Int?    = nil
  var daytime      : String? = nil
  var polar        : Bool?   = nil
  var freshSnowMm  : Int?    = nil

  enum CodingKeys: String, CodingKey {

    case Source       = "_source"
    case tempMin      = "temp_min"
    case tempAvg      = "temp_avg"
    case tempMax      = "temp_max"
    case windSpeed    = "wind_speed"
    case windGust     = "wind_gust"
    case windDir      = "wind_dir"
    case pressureMm   = "pressure_mm"
    case pressurePa   = "pressure_pa"
    case humidity     = "humidity"
    case soilTemp     = "soil_temp"
    case soilMoisture = "soil_moisture"
    case precMm       = "prec_mm"
    case precProb     = "prec_prob"
    case precPeriod   = "prec_period"
    case cloudness    = "cloudness"
    case precType     = "prec_type"
    case precStrength = "prec_strength"
    case icon         = "icon"
    case condition    = "condition"
    case uvIndex      = "uv_index"
    case feelsLike    = "feels_like"
    case daytime      = "daytime"
    case polar        = "polar"
    case freshSnowMm  = "fresh_snow_mm"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    Source       = try values.decodeIfPresent(String.self , forKey: .Source       )
    tempMin      = try values.decodeIfPresent(Int.self    , forKey: .tempMin      )
    tempAvg      = try values.decodeIfPresent(Int.self    , forKey: .tempAvg      )
    tempMax      = try values.decodeIfPresent(Int.self    , forKey: .tempMax      )
    windSpeed    = try values.decodeIfPresent(Double.self , forKey: .windSpeed    )
    windGust     = try values.decodeIfPresent(Double.self , forKey: .windGust     )
    windDir      = try values.decodeIfPresent(String.self , forKey: .windDir      )
    pressureMm   = try values.decodeIfPresent(Int.self    , forKey: .pressureMm   )
    pressurePa   = try values.decodeIfPresent(Int.self    , forKey: .pressurePa   )
    humidity     = try values.decodeIfPresent(Int.self    , forKey: .humidity     )
    soilTemp     = try values.decodeIfPresent(Int.self    , forKey: .soilTemp     )
    soilMoisture = try values.decodeIfPresent(Double.self , forKey: .soilMoisture )
    precMm       = try values.decodeIfPresent(Int.self    , forKey: .precMm       )
    precProb     = try values.decodeIfPresent(Int.self    , forKey: .precProb     )
    precPeriod   = try values.decodeIfPresent(Int.self    , forKey: .precPeriod   )
    cloudness    = try values.decodeIfPresent(Double.self , forKey: .cloudness    )
    precType     = try values.decodeIfPresent(Int.self    , forKey: .precType     )
    precStrength = try values.decodeIfPresent(Int.self    , forKey: .precStrength )
    icon         = try values.decodeIfPresent(String.self , forKey: .icon         )
    condition    = try values.decodeIfPresent(String.self , forKey: .condition    )
    uvIndex      = try values.decodeIfPresent(Int.self    , forKey: .uvIndex      )
    feelsLike    = try values.decodeIfPresent(Int.self    , forKey: .feelsLike    )
    daytime      = try values.decodeIfPresent(String.self , forKey: .daytime      )
    polar        = try values.decodeIfPresent(Bool.self   , forKey: .polar        )
    freshSnowMm  = try values.decodeIfPresent(Int.self    , forKey: .freshSnowMm  )
 
  }

  init() {

  }

}

struct DayShort: Codable {

  var Source       : String? = nil
  var temp         : Int?    = nil
  var tempMin      : Int?    = nil
  var windSpeed    : Int?    = nil
  var windGust     : Double? = nil
  var windDir      : String? = nil
  var pressureMm   : Int?    = nil
  var pressurePa   : Int?    = nil
  var humidity     : Int?    = nil
  var soilTemp     : Int?    = nil
  var soilMoisture : Double? = nil
  var precMm       : Int?    = nil
  var precProb     : Int?    = nil
  var precPeriod   : Int?    = nil
  var cloudness    : Double? = nil
  var precType     : Int?    = nil
  var precStrength : Int?    = nil
  var icon         : String? = nil
  var condition    : String? = nil
  var uvIndex      : Int?    = nil
  var feelsLike    : Int?    = nil
  var daytime      : String? = nil
  var polar        : Bool?   = nil
  var freshSnowMm  : Int?    = nil

  enum CodingKeys: String, CodingKey {

    case Source       = "_source"
    case temp         = "temp"
    case tempMin      = "temp_min"
    case windSpeed    = "wind_speed"
    case windGust     = "wind_gust"
    case windDir      = "wind_dir"
    case pressureMm   = "pressure_mm"
    case pressurePa   = "pressure_pa"
    case humidity     = "humidity"
    case soilTemp     = "soil_temp"
    case soilMoisture = "soil_moisture"
    case precMm       = "prec_mm"
    case precProb     = "prec_prob"
    case precPeriod   = "prec_period"
    case cloudness    = "cloudness"
    case precType     = "prec_type"
    case precStrength = "prec_strength"
    case icon         = "icon"
    case condition    = "condition"
    case uvIndex      = "uv_index"
    case feelsLike    = "feels_like"
    case daytime      = "daytime"
    case polar        = "polar"
    case freshSnowMm  = "fresh_snow_mm"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    Source       = try values.decodeIfPresent(String.self , forKey: .Source       )
    temp         = try values.decodeIfPresent(Int.self    , forKey: .temp         )
    tempMin      = try values.decodeIfPresent(Int.self    , forKey: .tempMin      )
    windSpeed    = try values.decodeIfPresent(Int.self    , forKey: .windSpeed    )
    windGust     = try values.decodeIfPresent(Double.self , forKey: .windGust     )
    windDir      = try values.decodeIfPresent(String.self , forKey: .windDir      )
    pressureMm   = try values.decodeIfPresent(Int.self    , forKey: .pressureMm   )
    pressurePa   = try values.decodeIfPresent(Int.self    , forKey: .pressurePa   )
    humidity     = try values.decodeIfPresent(Int.self    , forKey: .humidity     )
    soilTemp     = try values.decodeIfPresent(Int.self    , forKey: .soilTemp     )
    soilMoisture = try values.decodeIfPresent(Double.self , forKey: .soilMoisture )
    precMm       = try values.decodeIfPresent(Int.self    , forKey: .precMm       )
    precProb     = try values.decodeIfPresent(Int.self    , forKey: .precProb     )
    precPeriod   = try values.decodeIfPresent(Int.self    , forKey: .precPeriod   )
    cloudness    = try values.decodeIfPresent(Double.self , forKey: .cloudness    )
    precType     = try values.decodeIfPresent(Int.self    , forKey: .precType     )
    precStrength = try values.decodeIfPresent(Int.self    , forKey: .precStrength )
    icon         = try values.decodeIfPresent(String.self , forKey: .icon         )
    condition    = try values.decodeIfPresent(String.self , forKey: .condition    )
    uvIndex      = try values.decodeIfPresent(Int.self    , forKey: .uvIndex      )
    feelsLike    = try values.decodeIfPresent(Int.self    , forKey: .feelsLike    )
    daytime      = try values.decodeIfPresent(String.self , forKey: .daytime      )
    polar        = try values.decodeIfPresent(Bool.self   , forKey: .polar        )
    freshSnowMm  = try values.decodeIfPresent(Int.self    , forKey: .freshSnowMm  )
 
  }

  init() {

  }

}

struct Night: Codable {

  var Source       : String? = nil
  var tempMin      : Int?    = nil
  var tempAvg      : Int?    = nil
  var tempMax      : Int?    = nil
  var windSpeed    : Int?    = nil
  var windGust     : Double? = nil
  var windDir      : String? = nil
  var pressureMm   : Int?    = nil
  var pressurePa   : Int?    = nil
  var humidity     : Int?    = nil
  var soilTemp     : Int?    = nil
  var soilMoisture : Double? = nil
  var precMm       : Int?    = nil
  var precProb     : Int?    = nil
  var precPeriod   : Int?    = nil
  var cloudness    : Int?    = nil
  var precType     : Int?    = nil
  var precStrength : Int?    = nil
  var icon         : String? = nil
  var condition    : String? = nil
  var uvIndex      : Int?    = nil
  var feelsLike    : Int?    = nil
  var daytime      : String? = nil
  var polar        : Bool?   = nil
  var freshSnowMm  : Int?    = nil

  enum CodingKeys: String, CodingKey {

    case Source       = "_source"
    case tempMin      = "temp_min"
    case tempAvg      = "temp_avg"
    case tempMax      = "temp_max"
    case windSpeed    = "wind_speed"
    case windGust     = "wind_gust"
    case windDir      = "wind_dir"
    case pressureMm   = "pressure_mm"
    case pressurePa   = "pressure_pa"
    case humidity     = "humidity"
    case soilTemp     = "soil_temp"
    case soilMoisture = "soil_moisture"
    case precMm       = "prec_mm"
    case precProb     = "prec_prob"
    case precPeriod   = "prec_period"
    case cloudness    = "cloudness"
    case precType     = "prec_type"
    case precStrength = "prec_strength"
    case icon         = "icon"
    case condition    = "condition"
    case uvIndex      = "uv_index"
    case feelsLike    = "feels_like"
    case daytime      = "daytime"
    case polar        = "polar"
    case freshSnowMm  = "fresh_snow_mm"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    Source       = try values.decodeIfPresent(String.self , forKey: .Source       )
    tempMin      = try values.decodeIfPresent(Int.self    , forKey: .tempMin      )
    tempAvg      = try values.decodeIfPresent(Int.self    , forKey: .tempAvg      )
    tempMax      = try values.decodeIfPresent(Int.self    , forKey: .tempMax      )
    windSpeed    = try values.decodeIfPresent(Int.self    , forKey: .windSpeed    )
    windGust     = try values.decodeIfPresent(Double.self , forKey: .windGust     )
    windDir      = try values.decodeIfPresent(String.self , forKey: .windDir      )
    pressureMm   = try values.decodeIfPresent(Int.self    , forKey: .pressureMm   )
    pressurePa   = try values.decodeIfPresent(Int.self    , forKey: .pressurePa   )
    humidity     = try values.decodeIfPresent(Int.self    , forKey: .humidity     )
    soilTemp     = try values.decodeIfPresent(Int.self    , forKey: .soilTemp     )
    soilMoisture = try values.decodeIfPresent(Double.self , forKey: .soilMoisture )
    precMm       = try values.decodeIfPresent(Int.self    , forKey: .precMm       )
    precProb     = try values.decodeIfPresent(Int.self    , forKey: .precProb     )
    precPeriod   = try values.decodeIfPresent(Int.self    , forKey: .precPeriod   )
    cloudness    = try values.decodeIfPresent(Int.self    , forKey: .cloudness    )
    precType     = try values.decodeIfPresent(Int.self    , forKey: .precType     )
    precStrength = try values.decodeIfPresent(Int.self    , forKey: .precStrength )
    icon         = try values.decodeIfPresent(String.self , forKey: .icon         )
    condition    = try values.decodeIfPresent(String.self , forKey: .condition    )
    uvIndex      = try values.decodeIfPresent(Int.self    , forKey: .uvIndex      )
    feelsLike    = try values.decodeIfPresent(Int.self    , forKey: .feelsLike    )
    daytime      = try values.decodeIfPresent(String.self , forKey: .daytime      )
    polar        = try values.decodeIfPresent(Bool.self   , forKey: .polar        )
    freshSnowMm  = try values.decodeIfPresent(Int.self    , forKey: .freshSnowMm  )
 
  }

  init() {

  }

}

struct Morning: Codable {

  var Source       : String? = nil
  var tempMin      : Int?    = nil
  var tempAvg      : Int?    = nil
  var tempMax      : Int?    = nil
  var windSpeed    : Int?    = nil
  var windGust     : Double? = nil
  var windDir      : String? = nil
  var pressureMm   : Int?    = nil
  var pressurePa   : Int?    = nil
  var humidity     : Int?    = nil
  var soilTemp     : Int?    = nil
  var soilMoisture : Double? = nil
  var precMm       : Int?    = nil
  var precProb     : Int?    = nil
  var precPeriod   : Int?    = nil
  var cloudness    : Double? = nil
  var precType     : Int?    = nil
  var precStrength : Int?    = nil
  var icon         : String? = nil
  var condition    : String? = nil
  var uvIndex      : Int?    = nil
  var feelsLike    : Int?    = nil
  var daytime      : String? = nil
  var polar        : Bool?   = nil
  var freshSnowMm  : Int?    = nil

  enum CodingKeys: String, CodingKey {

    case Source       = "_source"
    case tempMin      = "temp_min"
    case tempAvg      = "temp_avg"
    case tempMax      = "temp_max"
    case windSpeed    = "wind_speed"
    case windGust     = "wind_gust"
    case windDir      = "wind_dir"
    case pressureMm   = "pressure_mm"
    case pressurePa   = "pressure_pa"
    case humidity     = "humidity"
    case soilTemp     = "soil_temp"
    case soilMoisture = "soil_moisture"
    case precMm       = "prec_mm"
    case precProb     = "prec_prob"
    case precPeriod   = "prec_period"
    case cloudness    = "cloudness"
    case precType     = "prec_type"
    case precStrength = "prec_strength"
    case icon         = "icon"
    case condition    = "condition"
    case uvIndex      = "uv_index"
    case feelsLike    = "feels_like"
    case daytime      = "daytime"
    case polar        = "polar"
    case freshSnowMm  = "fresh_snow_mm"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    Source       = try values.decodeIfPresent(String.self , forKey: .Source       )
    tempMin      = try values.decodeIfPresent(Int.self    , forKey: .tempMin      )
    tempAvg      = try values.decodeIfPresent(Int.self    , forKey: .tempAvg      )
    tempMax      = try values.decodeIfPresent(Int.self    , forKey: .tempMax      )
    windSpeed    = try values.decodeIfPresent(Int.self    , forKey: .windSpeed    )
    windGust     = try values.decodeIfPresent(Double.self , forKey: .windGust     )
    windDir      = try values.decodeIfPresent(String.self , forKey: .windDir      )
    pressureMm   = try values.decodeIfPresent(Int.self    , forKey: .pressureMm   )
    pressurePa   = try values.decodeIfPresent(Int.self    , forKey: .pressurePa   )
    humidity     = try values.decodeIfPresent(Int.self    , forKey: .humidity     )
    soilTemp     = try values.decodeIfPresent(Int.self    , forKey: .soilTemp     )
    soilMoisture = try values.decodeIfPresent(Double.self , forKey: .soilMoisture )
    precMm       = try values.decodeIfPresent(Int.self    , forKey: .precMm       )
    precProb     = try values.decodeIfPresent(Int.self    , forKey: .precProb     )
    precPeriod   = try values.decodeIfPresent(Int.self    , forKey: .precPeriod   )
    cloudness    = try values.decodeIfPresent(Double.self , forKey: .cloudness    )
    precType     = try values.decodeIfPresent(Int.self    , forKey: .precType     )
    precStrength = try values.decodeIfPresent(Int.self    , forKey: .precStrength )
    icon         = try values.decodeIfPresent(String.self , forKey: .icon         )
    condition    = try values.decodeIfPresent(String.self , forKey: .condition    )
    uvIndex      = try values.decodeIfPresent(Int.self    , forKey: .uvIndex      )
    feelsLike    = try values.decodeIfPresent(Int.self    , forKey: .feelsLike    )
    daytime      = try values.decodeIfPresent(String.self , forKey: .daytime      )
    polar        = try values.decodeIfPresent(Bool.self   , forKey: .polar        )
    freshSnowMm  = try values.decodeIfPresent(Int.self    , forKey: .freshSnowMm  )
 
  }

  init() {

  }

}

struct NightShort: Codable {

  var Source       : String? = nil
  var temp         : Int?    = nil
  var windSpeed    : Int?    = nil
  var windGust     : Double? = nil
  var windDir      : String? = nil
  var pressureMm   : Int?    = nil
  var pressurePa   : Int?    = nil
  var humidity     : Int?    = nil
  var soilTemp     : Int?    = nil
  var soilMoisture : Double? = nil
  var precMm       : Int?    = nil
  var precProb     : Int?    = nil
  var precPeriod   : Int?    = nil
  var cloudness    : Int?    = nil
  var precType     : Int?    = nil
  var precStrength : Int?    = nil
  var icon         : String? = nil
  var condition    : String? = nil
  var uvIndex      : Int?    = nil
  var feelsLike    : Int?    = nil
  var daytime      : String? = nil
  var polar        : Bool?   = nil
  var freshSnowMm  : Int?    = nil

  enum CodingKeys: String, CodingKey {

    case Source       = "_source"
    case temp         = "temp"
    case windSpeed    = "wind_speed"
    case windGust     = "wind_gust"
    case windDir      = "wind_dir"
    case pressureMm   = "pressure_mm"
    case pressurePa   = "pressure_pa"
    case humidity     = "humidity"
    case soilTemp     = "soil_temp"
    case soilMoisture = "soil_moisture"
    case precMm       = "prec_mm"
    case precProb     = "prec_prob"
    case precPeriod   = "prec_period"
    case cloudness    = "cloudness"
    case precType     = "prec_type"
    case precStrength = "prec_strength"
    case icon         = "icon"
    case condition    = "condition"
    case uvIndex      = "uv_index"
    case feelsLike    = "feels_like"
    case daytime      = "daytime"
    case polar        = "polar"
    case freshSnowMm  = "fresh_snow_mm"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    Source       = try values.decodeIfPresent(String.self , forKey: .Source       )
    temp         = try values.decodeIfPresent(Int.self    , forKey: .temp         )
    windSpeed    = try values.decodeIfPresent(Int.self    , forKey: .windSpeed    )
    windGust     = try values.decodeIfPresent(Double.self , forKey: .windGust     )
    windDir      = try values.decodeIfPresent(String.self , forKey: .windDir      )
    pressureMm   = try values.decodeIfPresent(Int.self    , forKey: .pressureMm   )
    pressurePa   = try values.decodeIfPresent(Int.self    , forKey: .pressurePa   )
    humidity     = try values.decodeIfPresent(Int.self    , forKey: .humidity     )
    soilTemp     = try values.decodeIfPresent(Int.self    , forKey: .soilTemp     )
    soilMoisture = try values.decodeIfPresent(Double.self , forKey: .soilMoisture )
    precMm       = try values.decodeIfPresent(Int.self    , forKey: .precMm       )
    precProb     = try values.decodeIfPresent(Int.self    , forKey: .precProb     )
    precPeriod   = try values.decodeIfPresent(Int.self    , forKey: .precPeriod   )
    cloudness    = try values.decodeIfPresent(Int.self    , forKey: .cloudness    )
    precType     = try values.decodeIfPresent(Int.self    , forKey: .precType     )
    precStrength = try values.decodeIfPresent(Int.self    , forKey: .precStrength )
    icon         = try values.decodeIfPresent(String.self , forKey: .icon         )
    condition    = try values.decodeIfPresent(String.self , forKey: .condition    )
    uvIndex      = try values.decodeIfPresent(Int.self    , forKey: .uvIndex      )
    feelsLike    = try values.decodeIfPresent(Int.self    , forKey: .feelsLike    )
    daytime      = try values.decodeIfPresent(String.self , forKey: .daytime      )
    polar        = try values.decodeIfPresent(Bool.self   , forKey: .polar        )
    freshSnowMm  = try values.decodeIfPresent(Int.self    , forKey: .freshSnowMm  )
 
  }

  init() {

  }

}

struct Parts: Codable {

  var day        : Day?        = Day()
  var evening    : Evening?    = Evening()
  var dayShort   : DayShort?   = DayShort()
  var night      : Night?      = Night()
  var morning    : Morning?    = Morning()
  var nightShort : NightShort? = NightShort()

  enum CodingKeys: String, CodingKey {

    case day        = "day"
    case evening    = "evening"
    case dayShort   = "day_short"
    case night      = "night"
    case morning    = "morning"
    case nightShort = "night_short"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    day        = try values.decodeIfPresent(Day.self        , forKey: .day        )
    evening    = try values.decodeIfPresent(Evening.self    , forKey: .evening    )
    dayShort   = try values.decodeIfPresent(DayShort.self   , forKey: .dayShort   )
    night      = try values.decodeIfPresent(Night.self      , forKey: .night      )
    morning    = try values.decodeIfPresent(Morning.self    , forKey: .morning    )
    nightShort = try values.decodeIfPresent(NightShort.self , forKey: .nightShort )
 
  }

  init() {

  }

}

struct Hours: Codable {

  var hour         : String? = nil
  var hourTs       : Int?    = nil
  var temp         : Int?    = nil
  var feelsLike    : Int?    = nil
  var icon         : String? = nil
  var condition    : String? = nil
  var cloudness    : Int?    = nil
  var precType     : Int?    = nil
  var precStrength : Int?    = nil
  var isThunder    : Bool?   = nil
  var windDir      : String? = nil
  var windSpeed    : Int?    = nil
  var windGust     : Double? = nil
  var pressureMm   : Int?    = nil
  var pressurePa   : Int?    = nil
  var humidity     : Int?    = nil
  var uvIndex      : Int?    = nil
  var soilTemp     : Int?    = nil
  var soilMoisture : Double? = nil
  var precMm       : Int?    = nil
  var precPeriod   : Int?    = nil
  var precProb     : Int?    = nil

  enum CodingKeys: String, CodingKey {

    case hour         = "hour"
    case hourTs       = "hour_ts"
    case temp         = "temp"
    case feelsLike    = "feels_like"
    case icon         = "icon"
    case condition    = "condition"
    case cloudness    = "cloudness"
    case precType     = "prec_type"
    case precStrength = "prec_strength"
    case isThunder    = "is_thunder"
    case windDir      = "wind_dir"
    case windSpeed    = "wind_speed"
    case windGust     = "wind_gust"
    case pressureMm   = "pressure_mm"
    case pressurePa   = "pressure_pa"
    case humidity     = "humidity"
    case uvIndex      = "uv_index"
    case soilTemp     = "soil_temp"
    case soilMoisture = "soil_moisture"
    case precMm       = "prec_mm"
    case precPeriod   = "prec_period"
    case precProb     = "prec_prob"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    hour         = try values.decodeIfPresent(String.self , forKey: .hour         )
    hourTs       = try values.decodeIfPresent(Int.self    , forKey: .hourTs       )
    temp         = try values.decodeIfPresent(Int.self    , forKey: .temp         )
    feelsLike    = try values.decodeIfPresent(Int.self    , forKey: .feelsLike    )
    icon         = try values.decodeIfPresent(String.self , forKey: .icon         )
    condition    = try values.decodeIfPresent(String.self , forKey: .condition    )
    cloudness    = try values.decodeIfPresent(Int.self    , forKey: .cloudness    )
    precType     = try values.decodeIfPresent(Int.self    , forKey: .precType     )
    precStrength = try values.decodeIfPresent(Int.self    , forKey: .precStrength )
    isThunder    = try values.decodeIfPresent(Bool.self   , forKey: .isThunder    )
    windDir      = try values.decodeIfPresent(String.self , forKey: .windDir      )
    windSpeed    = try values.decodeIfPresent(Int.self    , forKey: .windSpeed    )
    windGust     = try values.decodeIfPresent(Double.self , forKey: .windGust     )
    pressureMm   = try values.decodeIfPresent(Int.self    , forKey: .pressureMm   )
    pressurePa   = try values.decodeIfPresent(Int.self    , forKey: .pressurePa   )
    humidity     = try values.decodeIfPresent(Int.self    , forKey: .humidity     )
    uvIndex      = try values.decodeIfPresent(Int.self    , forKey: .uvIndex      )
    soilTemp     = try values.decodeIfPresent(Int.self    , forKey: .soilTemp     )
    soilMoisture = try values.decodeIfPresent(Double.self , forKey: .soilMoisture )
    precMm       = try values.decodeIfPresent(Int.self    , forKey: .precMm       )
    precPeriod   = try values.decodeIfPresent(Int.self    , forKey: .precPeriod   )
    precProb     = try values.decodeIfPresent(Int.self    , forKey: .precProb     )
 
  }

  init() {

  }

}

struct Biomet: Codable {

  var index     : Int?    = nil
  var condition : String? = nil

  enum CodingKeys: String, CodingKey {

    case index     = "index"
    case condition = "condition"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    index     = try values.decodeIfPresent(Int.self    , forKey: .index     )
    condition = try values.decodeIfPresent(String.self , forKey: .condition )
 
  }

  init() {

  }

}

struct Forecasts: Codable {

  var date      : String?  = nil
  var dateTs    : Int?     = nil
  var week      : Int?     = nil
  var sunrise   : String?  = nil
  var sunset    : String?  = nil
  var riseBegin : String?  = nil
  var setEnd    : String?  = nil
  var moonCode  : Int?     = nil
  var moonText  : String?  = nil
  var parts     : Parts?   = Parts()
  var hours     : [Hours]? = []
  var biomet    : Biomet?  = Biomet()

  enum CodingKeys: String, CodingKey {

    case date      = "date"
    case dateTs    = "date_ts"
    case week      = "week"
    case sunrise   = "sunrise"
    case sunset    = "sunset"
    case riseBegin = "rise_begin"
    case setEnd    = "set_end"
    case moonCode  = "moon_code"
    case moonText  = "moon_text"
    case parts     = "parts"
    case hours     = "hours"
    case biomet    = "biomet"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    date      = try values.decodeIfPresent(String.self  , forKey: .date      )
    dateTs    = try values.decodeIfPresent(Int.self     , forKey: .dateTs    )
    week      = try values.decodeIfPresent(Int.self     , forKey: .week      )
    sunrise   = try values.decodeIfPresent(String.self  , forKey: .sunrise   )
    sunset    = try values.decodeIfPresent(String.self  , forKey: .sunset    )
    riseBegin = try values.decodeIfPresent(String.self  , forKey: .riseBegin )
    setEnd    = try values.decodeIfPresent(String.self  , forKey: .setEnd    )
    moonCode  = try values.decodeIfPresent(Int.self     , forKey: .moonCode  )
    moonText  = try values.decodeIfPresent(String.self  , forKey: .moonText  )
    parts     = try values.decodeIfPresent(Parts.self   , forKey: .parts     )
    hours     = try values.decodeIfPresent([Hours].self , forKey: .hours     )
    biomet    = try values.decodeIfPresent(Biomet.self  , forKey: .biomet    )
 
  }

  init() {

  }

}


















