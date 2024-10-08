import Combine
import Foundation
import OSLog

// MARK: - AppSettingsStore

// swiftlint:disable file_length

/// A protocol for an object that persists app setting values.
///
protocol AppSettingsStore: AnyObject {
    /// Whether the autofill info prompt has been shown.
    var addSitePromptShown: Bool { get set }

    /// The app's unique identifier.
    var appId: String? { get set }

    /// The app's locale.
    var appLocale: String? { get set }

    /// The app's theme.
    var appTheme: String? { get set }

    /// The legacy system biometric integrity state `Data`, base64 encoded.
    ///
    /// NOTE: This is only used for migrating from the legacy app and isn't constrained to a
    ///     specific user, `biometricIntegrityState(userId:)` should be used instead.
    ///
    var biometricIntegrityStateLegacy: String? { get set }

    /// Whether to disable the website icons.
    var disableWebIcons: Bool { get set }

    /// Whether the intro carousel screen has been shown.
    var introCarouselShown: Bool { get set }

    /// The last value of the connect to watch setting, ignoring the user id. Used for
    /// sending the status to the watch if the user is logged out.
    var lastUserShouldConnectToWatch: Bool { get set }

    /// The login request information received from a push notification.
    var loginRequest: LoginRequestNotification? { get set }

    /// The app's last data migration version.
    var migrationVersion: Int { get set }

    /// The environment URLs used prior to user authentication.
    var preAuthEnvironmentUrls: EnvironmentUrlData? { get set }

    /// The email being remembered on the landing screen.
    var rememberedEmail: String? { get set }

    /// The organization identifier being remembered on the single-sign on screen.
    var rememberedOrgIdentifier: String? { get set }

    /// The app's account state.
    var state: State? { get set }

    /// Whether the vault should sync on refreshing.
    ///
    /// - Parameter userId: The user ID associated with the sync on refresh setting.
    ///
    /// - Returns: Whether the vault should sync on refreshing.
    ///
    func allowSyncOnRefresh(userId: String) -> Bool

    /// The system biometric integrity state `Data`, base64 encoded.
    ///
    /// - Parameter userId: The user ID associated with the Biometric Integrity State.
    /// - Returns: A base64 encoded `String`
    ///  representing the last known Biometric Integrity State `Data` for the userID.
    ///
    func biometricIntegrityState(userId: String) -> String?

    /// Gets the time after which the clipboard should be cleared.
    ///
    /// - Parameter userId: The user ID associated with the clipboard clearing time.
    ///
    /// - Returns: The time after which the clipboard should be cleared.
    ///
    func clearClipboardValue(userId: String) -> ClearClipboardValue

    /// Gets the connect to watch setting for the user.
    ///
    /// - Parameter userId: The user ID associated with the connect to watch value.
    ///
    /// - Returns: Whether to connect to the watch app.
    ///
    func connectToWatch(userId: String) -> Bool

    /// Gets the default URI match type.
    ///
    /// - Parameter userId: The user ID associated with the default URI match type.
    /// - Returns: The default URI match type.
    ///
    func defaultUriMatchType(userId: String) -> UriMatchType?

    /// Gets the disable auto-copy TOTP value for the user ID.
    ///
    /// - Parameter userId: The user ID associated with the disable auto-copy TOTP value.
    ///
    func disableAutoTotpCopy(userId: String) -> Bool

    /// The user's pin protected by their user key.
    ///
    /// - Parameter userId: The user ID associated with the encrypted pin.
    /// - Returns: The user's pin protected by their user key.
    ///
    func encryptedPin(userId: String) -> String?

    /// The user's events to be uploaded.
    ///
    /// - Parameters:
    ///   - userId: The user ID associated with the events.
    /// - Returns: The user's events.
    ///
    func events(userId: String) -> [EventData]

    /// Gets the encrypted private key for the user ID.
    ///
    /// - Parameter userId: The user ID associated with the encrypted private key.
    ///
    func encryptedPrivateKey(userId: String) -> String?

    /// Gets the encrypted user key for the user ID.
    ///
    /// - Parameter userId: The user ID associated with the encrypted user key.
    ///
    func encryptedUserKey(userId: String) -> String?

    /// The user's last active time within the app.
    /// This value is set when the app is backgrounded.
    ///
    /// - Parameter userId: The user ID associated with the last active time within the app.
    ///
    func lastActiveTime(userId: String) -> Date?

    /// Get the user's Biometric Authentication Preference.
    ///
    /// - Parameter userId: The user ID associated with the biometric authentication preference.
    ///
    /// - Returns: A `Bool` indicating the user's preference for using biometric authentication.
    ///     If `true`, the device should attempt biometric authentication for authorization events.
    ///     If `false`, the device should not attempt biometric authentication for authorization events.
    ///
    func isBiometricAuthenticationEnabled(userId: String) -> Bool

    /// Gets the time of the last sync for the user ID.
    ///
    /// - Parameter userId: The user ID associated with the last sync time.
    /// - Returns: The time of the last sync for the user.
    ///
    func lastSyncTime(userId: String) -> Date?

    /// Gets the master password hash for the user ID.
    ///
    /// - Parameter userId: The user ID associated with the master password hash.
    /// - Returns: The master password hash for the user.
    ///
    func masterPasswordHash(userId: String) -> String?

    /// Gets the last date the user successfully registered for push notifications.
    ///
    /// - Parameter userId: The user ID associated with the last notifications registration date.
    /// - Returns: The last notifications registration date for the user.
    ///
    func notificationsLastRegistrationDate(userId: String) -> Date?

    /// Gets the password generation options for a user ID.
    ///
    /// - Parameter userId: The user ID associated with the password generation options.
    /// - Returns: The password generation options for the user ID.
    ///
    func passwordGenerationOptions(userId: String) -> PasswordGenerationOptions?

    /// The pin protected user key.
    ///
    /// - Parameter userId: The user ID associated with the pin protected user key.
    /// - Returns: The pin protected user key.
    ///
    func pinProtectedUserKey(userId: String) -> String?

    /// The server configuration.
    ///
    /// - Parameter userId: The user ID associated with the server config.
    /// - Returns: The server config for that user ID.
    func serverConfig(userId: String) -> ServerConfig?

    /// Whether the vault should sync on refreshing.
    ///
    /// - Parameters:
    ///   - allowSyncOnRefresh: Whether the vault should sync on refreshing.
    ///   - userId: The user ID associated with the sync on refresh setting.
    ///
    func setAllowSyncOnRefresh(_ allowSyncOnRefresh: Bool?, userId: String)

    /// Sets the user's Biometric Authentication Preference.
    ///
    /// - Parameters:
    ///   - isEnabled: A `Bool` indicating the user's preference for using biometric authentication.
    ///     If `true`, the device should attempt biometric authentication for authorization events.
    ///     If `false`, the device should not attempt biometric authentication for authorization events.
    ///   - userId: The user ID associated with the biometric authentication preference.
    ///
    func setBiometricAuthenticationEnabled(_ isEnabled: Bool?, for userId: String)

    /// Sets a biometric integrity state `Data` as a base64 encoded `String`.
    ///
    /// - Parameters:
    ///   - base64EncodedIntegrityState: The biometric integrity state `Data`, encoded as a base64 `String`.
    ///   - userId: The user ID associated with the Biometric Integrity State.
    ///
    func setBiometricIntegrityState(_ base64EncodedIntegrityState: String?, userId: String)

    /// Sets the time after which the clipboard should be cleared.
    ///
    /// - Parameters:
    ///   - clearClipboardValue: The time after which the clipboard should be cleared.
    ///   - userId: The user ID associated with the clipboard clearing time.
    ///
    /// - Returns: The time after which the clipboard should be cleared.
    ///
    func setClearClipboardValue(_ clearClipboardValue: ClearClipboardValue?, userId: String)

    /// Sets the connect to watch setting for the user.
    ///
    /// - Parameters:
    ///   - connectToWatch: Whether to connect to the watch app.
    ///   - userId: The user ID associated with the connect to watch value.
    ///
    func setConnectToWatch(_ connectToWatch: Bool, userId: String)

    /// Sets the default URI match type.
    ///
    /// - Parameters:
    ///   - uriMatchType: The default URI match type.
    ///   - userId: The user ID associated with the default URI match type.
    ///
    func setDefaultUriMatchType(_ uriMatchType: UriMatchType?, userId: String)

    /// Sets the disable auto-copy TOTP value for a user ID.
    ///
    /// - Parameters:
    ///   - disableAutoTotpCopy: The user's disable auto-copy TOTP value.
    ///   - userId: The user ID associated with the disable auto-copy TOTP value.
    ///
    func setDisableAutoTotpCopy(_ disableAutoTotpCopy: Bool?, userId: String)

    /// Sets the user's pin protected by their user key.
    ///
    /// - Parameters:
    ///   - encryptedPin: The user's pin protected by their user key.
    ///   - userId: The user ID.
    ///
    func setEncryptedPin(_ encryptedPin: String?, userId: String)

    /// Sets the encrypted private key for a user ID.
    ///
    /// - Parameters:
    ///   - key: The user's encrypted private key.
    ///   - userId: The user ID associated with the encrypted private key.
    ///
    func setEncryptedPrivateKey(key: String?, userId: String)

    /// Sets the encrypted user key for a user ID.
    ///
    /// - Parameters:
    ///   - key: The user's encrypted user key.
    ///   - userId: The user ID associated with the encrypted user key.
    ///
    func setEncryptedUserKey(key: String?, userId: String)

    /// Sets the user's events for a user ID.
    ///
    /// - Parameters:
    ///   - events: The user's events.
    ///   - userId: The user ID associated with the events.
    ///
    func setEvents(_ events: [EventData], userId: String)

    /// Sets the last active time within the app.
    ///
    /// - Parameters:
    ///   - date: The current time.
    ///   - userId: The user ID associated with the last active time within the app.
    ///
    func setLastActiveTime(_ date: Date?, userId: String)

    /// Sets the time of the last sync for the user ID.
    ///
    /// - Parameters:
    ///   - date: The time of the last sync.
    ///   - userId: The user ID associated with the last sync time.
    ///
    func setLastSyncTime(_ date: Date?, userId: String)

    /// Sets the master password hash for a user ID.
    ///
    /// - Parameters:
    ///   - hash: The user's master password hash.
    ///   - userId: The user ID associated with the master password hash.
    ///
    func setMasterPasswordHash(_ hash: String?, userId: String)

    /// Sets the last notifications registration date for a user ID.
    ///
    /// - Parameters:
    ///   - date: The last notifications registration date.
    ///   - userId: The user ID associated with the last notifications registration date.
    ///
    func setNotificationsLastRegistrationDate(_ date: Date?, userId: String)

    /// Sets the password generation options for a user ID.
    ///
    /// - Parameters:
    ///   - options: The user's password generation options.
    ///   - userId: The user ID associated with the password generation options.
    ///
    func setPasswordGenerationOptions(_ options: PasswordGenerationOptions?, userId: String)

    /// Sets the pin protected user key.
    ///
    /// - Parameters:
    ///  - key: A pin protected user key derived from the user's pin.
    ///   - userId: The user ID.
    ///
    func setPinProtectedUserKey(key: String?, userId: String)

    /// Sets the server config.
    ///
    /// - Parameters:
    ///   - config: The server config for the user
    ///   - userId: The user ID.
    ///
    func setServerConfig(_ config: ServerConfig?, userId: String)

    /// Set whether to trust the device.
    ///
    /// - Parameter shouldTrustDevice: Whether to trust the device.
    ///
    func setShouldTrustDevice(shouldTrustDevice: Bool?, userId: String)

    /// Sets the user's timeout action.
    ///
    /// - Parameters:
    ///   - key: The action taken when a session has timed out.
    ///   - userId: The user ID associated with the session timeout action.
    ///
    func setTimeoutAction(key: SessionTimeoutAction, userId: String)

    /// Sets the two-factor token.
    ///
    /// - Parameters:
    ///   - token: The two-factor token.
    ///   - email: The user's email address.
    ///
    func setTwoFactorToken(_ token: String?, email: String)

    /// Sets the number of unsuccessful attempts to unlock the vault for a user ID.
    ///
    /// - Parameters:
    ///  -  attempts: The number of unsuccessful unlock attempts..
    ///  -  userId: The user ID associated with the unsuccessful unlock attempts.
    ///
    func setUnsuccessfulUnlockAttempts(_ attempts: Int, userId: String)

    /// Sets the user's session timeout, in minutes.
    ///
    /// - Parameters:
    ///   - key: The session timeout, in minutes.
    ///   - userId: The user ID associated with the session timeout.
    ///
    func setVaultTimeout(minutes: Int, userId: String)

    /// Sets the username generation options for a user ID.
    ///
    /// - Parameters:
    ///   - options: The user's username generation options.
    ///   - userId: The user ID associated with the username generation options.
    ///
    func setUsernameGenerationOptions(_ options: UsernameGenerationOptions?, userId: String)

    /// Get whether the device should be trusted.
    ///
    /// - Returns: Whether to trust the device.
    ///
    func shouldTrustDevice(userId: String) -> Bool?

    /// Returns the action taken upon a session timeout.
    ///
    /// - Parameter userId: The user ID associated with the session timeout action.
    /// - Returns: The  user's session timeout action.
    ///
    func timeoutAction(userId: String) -> Int?

    /// Get the two-factor token associated with a user's email.
    ///
    /// - Parameter email: The user's email.
    /// - Returns: The two-factor token.
    ///
    func twoFactorToken(email: String) -> String?

    /// Gets the username generation options for a user ID.
    ///
    /// - Parameter userId: The user ID associated with the username generation options.
    /// - Returns: The username generation options for the user ID.
    ///
    func usernameGenerationOptions(userId: String) -> UsernameGenerationOptions?

    /// Gets the number of unsuccessful attempts to unlock the vault for a user ID.
    ///
    /// - Parameter userId: The user ID associated with the unsuccessful unlock attempts.
    /// - Returns: The number of unsuccessful attempts to unlock the vault.
    ///
    func unsuccessfulUnlockAttempts(userId: String) -> Int

    /// Returns the session timeout in minutes.
    ///
    /// - Parameter userId: The user ID associated with the session timeout.
    /// - Returns: The user's session timeout in minutes.
    ///
    func vaultTimeout(userId: String) -> Int?

    // MARK: Publishers

    /// A publisher for the active account id
    ///
    /// - Returns: The userId `String` of the active account
    ///
    func activeAccountIdPublisher() -> AnyPublisher<String?, Never>
}

// MARK: - DefaultAppSettingsStore

/// A default `AppSettingsStore` which persists app settings in `UserDefaults`.
///
class DefaultAppSettingsStore {
    // MARK: Properties

    /// The `UserDefaults` instance to persist settings.
    let userDefaults: UserDefaults

    /// A subject containing a `String?` for the userId of the active account.
    lazy var activeAccountIdSubject = CurrentValueSubject<String?, Never>(state?.activeUserId)

    /// The bundleId used to set values that are bundleId dependent.
    var bundleId: String {
        Bundle.main.bundleIdentifier ?? Bundle.main.appIdentifier
    }

    // MARK: Initialization

    /// Initialize a `DefaultAppSettingsStore`.
    ///
    /// - Parameter userDefaults: The `UserDefaults` instance to persist settings.
    ///
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }

    // MARK: Private

    /// Fetches a `Bool` for the given key from `UserDefaults`.
    ///
    /// - Parameter key: The key used to store the value.
    /// - Returns: The value associated with the given key.
    ///
    private func fetch(for key: Keys) -> Bool {
        userDefaults.bool(forKey: key.storageKey)
    }

    /// Fetches a `Int` for the given key from `UserDefaults`.
    ///
    /// - Parameter key: The key used to store the value.
    /// - Returns: The value associated with the given key.
    ///
    private func fetch(for key: Keys) -> Int {
        userDefaults.integer(forKey: key.storageKey)
    }

    /// Fetches a `String` for the given key from `UserDefaults`.
    ///
    /// - Parameter key: The key used to store the value.
    /// - Returns: The value associated with the given key.
    ///
    private func fetch(for key: Keys) -> String? {
        userDefaults.string(forKey: key.storageKey)
    }

    /// Fetches and decodes a JSON encoded object for the given key from `UserDefaults`.
    ///
    /// - Parameters:
    ///   - key: The key used to store the value.
    ///   - decoder: The `JSONDecoder` used to decode JSON into the object type.
    /// - Returns: The value associated with the given key, decoded from JSON.
    ///
    private func fetch<T: Codable>(for key: Keys, decoder: JSONDecoder = JSONDecoder()) -> T? {
        guard let string = userDefaults.string(forKey: key.storageKey) else {
            return nil
        }

        do {
            return try decoder.decode(T.self, from: Data(string.utf8))
        } catch {
            Logger.application.error("Error fetching \(key.storageKey) from UserDefaults: \(error)")
            return nil
        }
    }

    /// Stores a `String` associated with the given key in `UserDefaults`.
    ///
    /// - Parameters:
    ///   - value: The value to store associated with the key.
    ///   - key: The key to associate with the value for retrieving it later.
    ///
    private func store(_ value: String?, for key: Keys) {
        userDefaults.set(value, forKey: key.storageKey)
    }

    /// Stores a JSON encoded object associated with the given key in `UserDefaults`.
    ///
    /// - Parameters:
    ///   - value: The value to store as JSON encoded data associated with the key.
    ///   - key:  The key to associate with the value for retrieving it later.
    ///   - encoder: The `JSONEncoder` used to encode the value as JSON.
    ///
    private func store<T: Codable>(_ value: T?, for key: Keys, encoder: JSONEncoder = JSONEncoder()) {
        guard let value else {
            userDefaults.removeObject(forKey: key.storageKey)
            return
        }

        do {
            let data = try encoder.encode(value)
            userDefaults.set(String(data: data, encoding: .utf8), forKey: key.storageKey)
        } catch {
            Logger.application.error(
                "Error storing \(key.storageKey): \(String(describing: value)) to UserDefaults: \(error)"
            )
        }
    }
}

extension DefaultAppSettingsStore: AppSettingsStore {
    /// The keys used to store their associated values.
    ///
    enum Keys {
        case addSitePromptShown
        case allowSyncOnRefresh(userId: String)
        case appId
        case appLocale
        case appTheme
        case biometricAuthEnabled(userId: String)
        case biometricIntegrityState(userId: String, bundleId: String)
        case biometricIntegrityStateLegacy
        case clearClipboardValue(userId: String)
        case connectToWatch(userId: String)
        case defaultUriMatch(userId: String)
        case disableAutoTotpCopy(userId: String)
        case disableWebIcons
        case encryptedPin(userId: String)
        case encryptedPrivateKey(userId: String)
        case encryptedUserKey(userId: String)
        case events(userId: String)
        case introCarouselShown
        case lastActiveTime(userId: String)
        case lastSync(userId: String)
        case lastUserShouldConnectToWatch
        case loginRequest
        case masterPasswordHash(userId: String)
        case migrationVersion
        case notificationsLastRegistrationDate(userId: String)
        case passwordGenerationOptions(userId: String)
        case pinProtectedUserKey(userId: String)
        case preAuthEnvironmentUrls
        case rememberedEmail
        case rememberedOrgIdentifier
        case serverConfig(userId: String)
        case shouldTrustDevice(userId: String)
        case state
        case twoFactorToken(email: String)
        case unsuccessfulUnlockAttempts(userId: String)
        case usernameGenerationOptions(userId: String)
        case vaultTimeout(userId: String)
        case vaultTimeoutAction(userId: String)

        /// Returns the key used to store the data under for retrieving it later.
        var storageKey: String {
            let key: String
            switch self {
            case .addSitePromptShown:
                key = "addSitePromptShown"
            case let .allowSyncOnRefresh(userId):
                key = "syncOnRefresh_\(userId)"
            case .appId:
                key = "appId"
            case .appLocale:
                key = "appLocale"
            case .appTheme:
                key = "theme"
            case let .biometricAuthEnabled(userId):
                key = "biometricUnlock_\(userId)"
            case let .biometricIntegrityState(userId, bundleId):
                key = "biometricIntegritySource_\(userId)_\(bundleId)"
            case .biometricIntegrityStateLegacy:
                key = "biometricIntegritySource"
            case let .clearClipboardValue(userId):
                key = "clearClipboard_\(userId)"
            case let .connectToWatch(userId):
                key = "shouldConnectToWatch_\(userId)"
            case let .defaultUriMatch(userId):
                key = "defaultUriMatch_\(userId)"
            case let .disableAutoTotpCopy(userId):
                key = "disableAutoTotpCopy_\(userId)"
            case .disableWebIcons:
                key = "disableFavicon"
            case let .encryptedUserKey(userId):
                key = "masterKeyEncryptedUserKey_\(userId)"
            case let .encryptedPin(userId):
                key = "protectedPin_\(userId)"
            case let .encryptedPrivateKey(userId):
                key = "encPrivateKey_\(userId)"
            case let .events(userId):
                key = "events_\(userId)"
            case .introCarouselShown:
                key = "introCarouselShown"
            case let .lastActiveTime(userId):
                key = "lastActiveTime_\(userId)"
            case let .lastSync(userId):
                key = "lastSync_\(userId)"
            case .lastUserShouldConnectToWatch:
                key = "lastUserShouldConnectToWatch"
            case .loginRequest:
                key = "passwordlessLoginNotificationKey"
            case let .masterPasswordHash(userId):
                key = "keyHash_\(userId)"
            case .migrationVersion:
                key = "migrationVersion"
            case let .notificationsLastRegistrationDate(userId):
                key = "pushLastRegistrationDate_\(userId)"
            case let .passwordGenerationOptions(userId):
                key = "passwordGenerationOptions_\(userId)"
            case let .pinProtectedUserKey(userId):
                key = "pinKeyEncryptedUserKey_\(userId)"
            case .preAuthEnvironmentUrls:
                key = "preAuthEnvironmentUrls"
            case .rememberedEmail:
                key = "rememberedEmail"
            case .rememberedOrgIdentifier:
                key = "rememberedOrgIdentifier"
            case let .serverConfig(userId):
                key = "serverConfig_\(userId)"
            case let .shouldTrustDevice(userId):
                key = "shouldTrustDevice_\(userId)"
            case .state:
                key = "state"
            case let .twoFactorToken(email):
                key = "twoFactorToken_\(email)"
            case let .unsuccessfulUnlockAttempts(userId):
                key = "invalidUnlockAttempts_\(userId)"
            case let .usernameGenerationOptions(userId):
                key = "usernameGenerationOptions_\(userId)"
            case let .vaultTimeout(userId):
                key = "vaultTimeout_\(userId)"
            case let .vaultTimeoutAction(userId):
                key = "vaultTimeoutAction_\(userId)"
            }
            return "bwPreferencesStorage:\(key)"
        }
    }

    var addSitePromptShown: Bool {
        get { fetch(for: .addSitePromptShown) }
        set { store(newValue, for: .addSitePromptShown) }
    }

    var appId: String? {
        get { fetch(for: .appId) }
        set { store(newValue, for: .appId) }
    }

    var appLocale: String? {
        get { fetch(for: .appLocale) }
        set { store(newValue, for: .appLocale) }
    }

    var appTheme: String? {
        get { fetch(for: .appTheme) }
        set { store(newValue, for: .appTheme) }
    }

    var biometricIntegrityStateLegacy: String? {
        get { fetch(for: .biometricIntegrityStateLegacy) }
        set { store(newValue, for: .biometricIntegrityStateLegacy) }
    }

    var disableWebIcons: Bool {
        get { fetch(for: .disableWebIcons) }
        set { store(newValue, for: .disableWebIcons) }
    }

    var introCarouselShown: Bool {
        get { fetch(for: .introCarouselShown) }
        set { store(newValue, for: .introCarouselShown) }
    }

    var lastUserShouldConnectToWatch: Bool {
        get { fetch(for: .lastUserShouldConnectToWatch) }
        set { store(newValue, for: .lastUserShouldConnectToWatch) }
    }

    var loginRequest: LoginRequestNotification? {
        get { fetch(for: .loginRequest) }
        set { store(newValue, for: .loginRequest) }
    }

    var migrationVersion: Int {
        get { fetch(for: .migrationVersion) }
        set { store(newValue, for: .migrationVersion) }
    }

    var preAuthEnvironmentUrls: EnvironmentUrlData? {
        get { fetch(for: .preAuthEnvironmentUrls) }
        set { store(newValue, for: .preAuthEnvironmentUrls) }
    }

    var rememberedEmail: String? {
        get { fetch(for: .rememberedEmail) }
        set { store(newValue, for: .rememberedEmail) }
    }

    var rememberedOrgIdentifier: String? {
        get { fetch(for: .rememberedOrgIdentifier) }
        set { store(newValue, for: .rememberedOrgIdentifier) }
    }

    var state: State? {
        get { fetch(for: .state) }
        set {
            activeAccountIdSubject.send(newValue?.activeUserId)
            return store(newValue, for: .state)
        }
    }

    func allowSyncOnRefresh(userId: String) -> Bool {
        fetch(for: .allowSyncOnRefresh(userId: userId))
    }

    func biometricIntegrityState(userId: String) -> String? {
        fetch(
            for: .biometricIntegrityState(
                userId: userId,
                bundleId: bundleId
            )
        )
    }

    func clearClipboardValue(userId: String) -> ClearClipboardValue {
        if let rawValue: Int = fetch(for: .clearClipboardValue(userId: userId)),
           let value = ClearClipboardValue(rawValue: rawValue) {
            return value
        }
        return .never
    }

    func connectToWatch(userId: String) -> Bool {
        fetch(for: .connectToWatch(userId: userId))
    }

    func defaultUriMatchType(userId: String) -> UriMatchType? {
        fetch(for: .defaultUriMatch(userId: userId))
    }

    func disableAutoTotpCopy(userId: String) -> Bool {
        fetch(for: .disableAutoTotpCopy(userId: userId))
    }

    func encryptedPin(userId: String) -> String? {
        fetch(for: .encryptedPin(userId: userId))
    }

    func encryptedPrivateKey(userId: String) -> String? {
        fetch(for: .encryptedPrivateKey(userId: userId))
    }

    func encryptedUserKey(userId: String) -> String? {
        fetch(for: .encryptedUserKey(userId: userId))
    }

    func events(userId: String) -> [EventData] {
        fetch(for: .events(userId: userId)) ?? []
    }

    func lastActiveTime(userId: String) -> Date? {
        fetch(for: .lastActiveTime(userId: userId)).map { Date(timeIntervalSince1970: $0) }
    }

    func isBiometricAuthenticationEnabled(userId: String) -> Bool {
        fetch(for: .biometricAuthEnabled(userId: userId))
    }

    func lastSyncTime(userId: String) -> Date? {
        fetch(for: .lastSync(userId: userId)).map { Date(timeIntervalSince1970: $0) }
    }

    func masterPasswordHash(userId: String) -> String? {
        fetch(for: .masterPasswordHash(userId: userId))
    }

    func notificationsLastRegistrationDate(userId: String) -> Date? {
        fetch(for: .notificationsLastRegistrationDate(userId: userId)).map { Date(timeIntervalSince1970: $0) }
    }

    func passwordGenerationOptions(userId: String) -> PasswordGenerationOptions? {
        fetch(for: .passwordGenerationOptions(userId: userId))
    }

    func pinProtectedUserKey(userId: String) -> String? {
        fetch(for: .pinProtectedUserKey(userId: userId))
    }

    func serverConfig(userId: String) -> ServerConfig? {
        fetch(for: .serverConfig(userId: userId))
    }

    func setAllowSyncOnRefresh(_ allowSyncOnRefresh: Bool?, userId: String) {
        store(allowSyncOnRefresh, for: .allowSyncOnRefresh(userId: userId))
    }

    func setBiometricAuthenticationEnabled(_ isEnabled: Bool?, for userId: String) {
        store(isEnabled, for: .biometricAuthEnabled(userId: userId))
    }

    func setBiometricIntegrityState(_ base64EncodedIntegrityState: String?, userId: String) {
        store(
            base64EncodedIntegrityState,
            for: .biometricIntegrityState(
                userId: userId,
                bundleId: bundleId
            )
        )
    }

    func setClearClipboardValue(_ clearClipboardValue: ClearClipboardValue?, userId: String) {
        store(clearClipboardValue?.rawValue, for: .clearClipboardValue(userId: userId))
    }

    func setConnectToWatch(_ connectToWatch: Bool, userId: String) {
        store(connectToWatch, for: .connectToWatch(userId: userId))
    }

    func setDefaultUriMatchType(_ uriMatchType: UriMatchType?, userId: String) {
        store(uriMatchType, for: .defaultUriMatch(userId: userId))
    }

    func setDisableAutoTotpCopy(_ disableAutoTotpCopy: Bool?, userId: String) {
        store(disableAutoTotpCopy, for: .disableAutoTotpCopy(userId: userId))
    }

    func setEncryptedPin(_ encryptedPin: String?, userId: String) {
        store(encryptedPin, for: .encryptedPin(userId: userId))
    }

    func setEncryptedPrivateKey(key: String?, userId: String) {
        store(key, for: .encryptedPrivateKey(userId: userId))
    }

    func setEncryptedUserKey(key: String?, userId: String) {
        store(key, for: .encryptedUserKey(userId: userId))
    }

    func setEvents(_ events: [EventData], userId: String) {
        store(events, for: .events(userId: userId))
    }

    func setLastActiveTime(_ date: Date?, userId: String) {
        store(date?.timeIntervalSince1970, for: .lastActiveTime(userId: userId))
    }

    func setLastSyncTime(_ date: Date?, userId: String) {
        store(date?.timeIntervalSince1970, for: .lastSync(userId: userId))
    }

    func setMasterPasswordHash(_ hash: String?, userId: String) {
        store(hash, for: .masterPasswordHash(userId: userId))
    }

    func setNotificationsLastRegistrationDate(_ date: Date?, userId: String) {
        store(date?.timeIntervalSince1970, for: .notificationsLastRegistrationDate(userId: userId))
    }

    func setPasswordGenerationOptions(_ options: PasswordGenerationOptions?, userId: String) {
        store(options, for: .passwordGenerationOptions(userId: userId))
    }

    func setPinProtectedUserKey(key: String?, userId: String) {
        store(key, for: .pinProtectedUserKey(userId: userId))
    }

    func setServerConfig(_ config: ServerConfig?, userId: String) {
        store(config, for: .serverConfig(userId: userId))
    }

    func setShouldTrustDevice(shouldTrustDevice: Bool?, userId: String) {
        store(shouldTrustDevice, for: .shouldTrustDevice(userId: userId))
    }

    func setTimeoutAction(key: SessionTimeoutAction, userId: String) {
        store(key, for: .vaultTimeoutAction(userId: userId))
    }

    func setTwoFactorToken(_ token: String?, email: String) {
        store(token, for: .twoFactorToken(email: email))
    }

    func setUsernameGenerationOptions(_ options: UsernameGenerationOptions?, userId: String) {
        store(options, for: .usernameGenerationOptions(userId: userId))
    }

    func setVaultTimeout(minutes: Int, userId: String) {
        store(minutes, for: .vaultTimeout(userId: userId))
    }

    func timeoutAction(userId: String) -> Int? {
        fetch(for: .vaultTimeoutAction(userId: userId))
    }

    func twoFactorToken(email: String) -> String? {
        fetch(for: .twoFactorToken(email: email))
    }

    func vaultTimeout(userId: String) -> Int? {
        fetch(for: .vaultTimeout(userId: userId))
    }

    func unsuccessfulUnlockAttempts(userId: String) -> Int {
        fetch(for: .unsuccessfulUnlockAttempts(userId: userId))
    }

    func usernameGenerationOptions(userId: String) -> UsernameGenerationOptions? {
        fetch(for: .usernameGenerationOptions(userId: userId))
    }

    func setUnsuccessfulUnlockAttempts(_ attempts: Int, userId: String) {
        store(attempts, for: .unsuccessfulUnlockAttempts(userId: userId))
    }

    func activeAccountIdPublisher() -> AnyPublisher<String?, Never> {
        activeAccountIdSubject.eraseToAnyPublisher()
    }

    func shouldTrustDevice(userId: String) -> Bool? {
        fetch(for: .shouldTrustDevice(userId: userId))
    }
}
