
import Swinject

extension SwinjectStoryboard {
    class func setup() {
        // Singletons
        
        let peopleStoreImpl = PeopleStoreImpl()
        let tokenStoreImpl = TokenStoreImpl()

        // View Controllers
        defaultContainer.registerForStoryboard(LoginViewController.self) { r, c in
            c.urlProvider = r.resolve(URLProvider.self)
            c.tokenStore = r.resolve(TokenStore.self)
        }
        
        defaultContainer.registerForStoryboard(PeopleViewController.self) { r, c in
            c.peopleStore = r.resolve(PeopleStore.self)
            c.peopleService = r.resolve(PeopleService.self)
        }
        
        defaultContainer.registerForStoryboard(GameViewController.self) { r, c in
            c.personChallengeService = r.resolve(PersonChallengeService.self)
            c.personDisplayer = r.resolve(PersonDisplayer.self)
            c.peopleStore = r.resolve(PeopleStore.self)
        }
        
        // Services
        defaultContainer.register(PersonChallengeService.self) { r in
            PersonChallengeServiceImpl(
                peopleRandomizer: r.resolve(PeopleRandomizer.self)!
            )
        }
        
        defaultContainer.register(PeopleService.self) { r in
            PeopleServiceImpl(
                tokenStore: r.resolve(TokenStore.self)!,
                session: NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
            )
        }
        
        defaultContainer.register(PeopleRandomizer.self) { _ in PeopleRandomizerImpl() }
        
        // Stores
        defaultContainer.register(PeopleStore.self) { _ in peopleStoreImpl }
        defaultContainer.register(TokenStore.self) { _ in tokenStoreImpl }
        
        // Utilities
        defaultContainer.register(PersonDisplayer.self) { _ in PersonDisplayerImpl() }
        defaultContainer.register(URLProvider.self) { _ in URLProviderImpl(baseURL: "https://pivots.pivotallabs.com") }
        
    }
}


