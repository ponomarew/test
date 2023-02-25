//
//  Configuration.swift
//  Demo
//
//  Created by Davide De Rosa on 6/13/20.
//  Copyright (c) 2021 Davide De Rosa. All rights reserved.
//
//  https://github.com/keeshux
//
//  This file is part of TunnelKit.
//
//  TunnelKit is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  TunnelKit is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with TunnelKit.  If not, see <http://www.gnu.org/licenses/>.
//

import Foundation
import TunnelKitCore
import TunnelKitOpenVPN

extension OpenVPN {
    struct DemoConfiguration {
        static func make() -> OpenVPNProvider.Configuration {
			let configURL = AppSettings.configPath ?? URL(fileURLWithPath: "")
			let file = try! OpenVPN.ConfigurationParser.parsed(fromURL: configURL)
			
            var sessionBuilder = OpenVPN.ConfigurationBuilder()
			sessionBuilder = file.configuration.builder()
            var builder = OpenVPNProvider.ConfigurationBuilder(sessionConfiguration: sessionBuilder.build())
            builder.shouldDebug = true
            builder.masksPrivateData = false
            return builder.build()
        }
    }
}
