

import TVMLKitchen
import PopcornKit


struct Popular: TabItem {
    
    let title = "Popular"
    let fetchType: Trakt.MediaType
    
    init(_ type: Trakt.MediaType) {
        fetchType = type
    }
    
    func handler() {
        var recipe: CatalogRecipe!
        switch fetchType {
        case .movies:
            recipe = CatalogRecipe(title: title, fetchBlock: { (page, completion) in
                PopcornKit.loadMovies(page, filterBy: .popularity) { (movies, error) in
                    completion(recipe, movies?.map({$0.lockUp}).joined(separator: ""), error, false)
                }
            })
        case .shows:
            recipe = CatalogRecipe(title: title, fetchBlock: { (page, completion) in
                PopcornKit.loadShows(page, filterBy: .popularity) { (shows, error) in
                    completion(recipe, shows?.map({$0.lockUp}).joined(separator: ""), error, false)
                }
            })
        default: return
        }
    }
}
