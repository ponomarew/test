//
//  VPNService.swift
//  VPNClient
//
//  Created by Александр Пономарёв on 01.11.2021.
//

import UIKit
import Alamofire
import Foundation
import TunnelKitCore
import TunnelKitManager
import TunnelKitOpenVPN
import NetworkExtension

struct ConnectionCredentials: Decodable {
	var result: String
	var status: String
	var key: String
	var serverId: String
	var message: String
}

struct Servers: Codable {
	let result: String?
	let servers: [Server]?
	let currPage, nextPage, countServers: Int?
}

struct Server: Codable {
	let id, name: String?
	let workload: Int?
}

struct ChangedServer: Codable {
	var result: String
	var status: String
	var key: String
	var serverId: String
	var message: String
}


//private let appGroup = "group.com.algoritmico.ios.TunnelKit.Demo.te"
//rivate let tunnelIdentifier = "com.algoritmico.ios.TunnelKit.Demo.te.OpenVPN.Tunnel"

class VPNService {
	static let shared = VPNService()
	
	private init() {}
	
	let id = UIDevice.current.identifierForVendor?.uuidString.replacingOccurrences(of: "-", with: "") ?? "id"
	
	private let vpn = OpenVPNProvider(bundleIdentifier: Config.packetTunnelProviderBundleId)
	
	private let keychain = Keychain(group: Config.appGroupName)
	//private var viewModel = ProfileViewModel()
	var localTimeZoneIdentifier: String { return TimeZone.current.identifier }
	var isSubscribed: String { if AppSettings.isFullVersion { return "1"} else { return "0"} }
	//UIDevice.current.identifierForVendor?.uuidString

	
	func addUser(completion: @escaping () -> ()) {
		let time = AppSettings.subTimestamp ?? Int(Date().timeIntervalSince1970 + 10)
		AF.request(
			"https://api.xservix.com/v1/index.php?mod=add_user",
			method: .post,
			parameters: [
				"deviceId": id,
				"type": "1",
				"deviceInfo": UIDevice.current.systemVersion,
				"timezone": localTimeZoneIdentifier,
				"expire": "\(time)",
				"isSubscribe": isSubscribed
			],
			encoder: JSONParameterEncoder.default
		)
		.validate()
		.responseDecodable(of: ConnectionCredentials.self) { (response) in
			if response.error != nil {
				completion()
				print("request error", response.error?.localizedDescription ?? "")
			}

			guard let creds = response.value else { return }
			print("key:", creds.key, "serverID:", creds.serverId)
			AppSettings.selectedServer = creds.serverId
			let destination: DownloadRequest.Destination = { _, _ in
				let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
				let fileURL = documentsURL.appendingPathComponent("config.ovpn")

				return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
			}

			if AppSettings.freeServer == nil || !AppSettings.isFullVersion {
				AppSettings.freeServer = creds.serverId
				AppSettings.selectedServer = AppSettings.freeServer
			}
			AF.download(creds.key, to: destination).response { response in
				if response.error != nil {
					completion()
					print("download error", response.error?.localizedDescription ?? "")
				}
				print("successed download", response.value)
				AppSettings.configPath = response.fileURL
				completion()
			}
		}
	}
	
	func startVPN() {
		let credentials = OpenVPN.Credentials("username", "pass")
		let cfg = OpenVPN.DemoConfiguration.make()
		let proto = try! cfg.generatedTunnelProtocol(
			withBundleIdentifier: Config.packetTunnelProviderBundleId,
			appGroup: Config.appGroupName,
			context: Config.packetTunnelProviderBundleId,
			credentials: credentials
		)
		let neCfg = NetworkExtensionVPNConfiguration(title: "PROVPN", protocolConfiguration: proto, onDemandRules: [])
		vpn.reconnect(configuration: neCfg) { (error) in
			if let error = error {
				print("configure error: \(error)")
				return
			}
		}
	}
	
	func offVPN() {
		vpn.disconnect(completionHandler: nil)
	}
	
	func vpnPrepare() {
		vpn.prepare(completionHandler: nil)
	}
	
	func getServers(completion: @escaping (Servers) -> ()) {
		AF.request(
			"https://api.xservix.com/v1/index.php?mod=servers&page=1&limit=50"
		)
		.validate()
		.responseDecodable(of: Servers.self) { (response) in
			if response.error != nil {
				print(response.error?.localizedDescription ?? "")
			}
			guard let value = response.value else { return }
			completion(value)
		}
	}
	
	
	
	func changeServer(id: String, completion: @escaping () -> ()) {
		let time = AppSettings.subTimestamp ?? Int(Date().timeIntervalSince1970 + 10)
		AF.request(
			"https://api.xservix.com/v1/index.php?mod=change_server",
			method: .post,
			parameters: [
				"deviceId": self.id,
				"expire": "\(time)",
				"serverId": id,
				"timezone": localTimeZoneIdentifier,
				"isSubscribe": isSubscribed
			],
			encoder: JSONParameterEncoder.default
		)
		.validate()
		.responseDecodable(of: ChangedServer.self) { (response) in
			if response.error != nil {
				print("error", response.error?.localizedDescription ?? "")
			}
			guard let response = response.value else { return }
			AppSettings.selectedServer = response.serverId
			print("success", response.serverId)
			let destination: DownloadRequest.Destination = { _, _ in
				let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
				let fileURL = documentsURL.appendingPathComponent("config.ovpn")

				return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
			}

			AF.download(response.key, to: destination).response { response in
				AppSettings.configPath = response.fileURL
				completion()
			}
		}
	}
	
	func readFile(path: String) -> Data? {
		let fileManager = FileManager.default
		do {
			let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
			let fileURL = documentDirectory.appendingPathComponent(path)
			return try Data(contentsOf: fileURL, options: .uncached)
		}
		catch let error {
			print(error.localizedDescription)
		}
		return nil
	}
}
