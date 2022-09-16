//
//  ghibliTests.swift
//  ghibliTests
//
//  Created by Isiah Marie Ramos Malit on 2022-09-12.
//

import XCTest
import Combine
@testable import ghibli

class ghibliViewModelTests: XCTestCase {
    
    var listViewModel: GhibliListViewModel?
    let service = MockService()

    override func setUpWithError() throws {
        listViewModel = GhibliListViewModel(
            service: service, state: .all
       )
    }

    override func tearDownWithError() throws {
        listViewModel = nil
    }

    func testGetData() throws {
        listViewModel?.getData(urlString: service.responseShort)
        XCTAssert(listViewModel?.personalizedMovies.count == 2)
    }
    
    func testFetchMore_Short() throws {
        listViewModel?.personalizedMovies = service.getMoviesFromText(response: service.responseShort) ?? []
        listViewModel?.fetchMore()
        XCTAssert(listViewModel?.scrollableMovies.count == listViewModel?.personalizedMovies.count)
        XCTAssert(listViewModel?.personalizedMovies.count ?? 0 < listViewModel?.movieLimitPerPage ?? 0)
    }
    
    func testFetchMore_Equal() throws {
        listViewModel?.personalizedMovies = service.getMoviesFromText(response: service.responseEqual) ?? []
        listViewModel?.fetchMore()
        XCTAssert(listViewModel?.scrollableMovies.count == listViewModel?.movieLimitPerPage)
        XCTAssert(listViewModel?.scrollableMovies.count == listViewModel?.personalizedMovies.count)
    }
    
    func testFetchMore_More() throws {
        listViewModel?.personalizedMovies = service.getMoviesFromText(response: service.responseMore) ?? []
        listViewModel?.fetchMore()
        XCTAssert(listViewModel?.scrollableMovies.count == listViewModel?.movieLimitPerPage)
        XCTAssert(listViewModel?.personalizedMovies.count ?? 0 > listViewModel?.movieLimitPerPage ?? 0)
    }
}

class MockService: ServiceProtocol {
    let responseShort =
    """
    [
        {
            "id": "2baf70d1-42bb-4437-b551-e5fed5a87abe",
            "title": "Castle in the Sky",
            "original_title": "天空の城ラピュタ",
            "original_title_romanised": "Tenkū no shiro Rapyuta",
            "image": "https://image.tmdb.org/t/p/w600_and_h900_bestv2/npOnzAbLh6VOIu3naU5QaEcTepo.jpg",
            "movie_banner": "https://image.tmdb.org/t/p/w533_and_h300_bestv2/3cyjYtLWCBE1uvWINHFsFnE8LUK.jpg",
            "description": "The orphan Sheeta inherited a mysterious crystal that links her to the mythical sky-kingdom of Laputa. With the help of resourceful Pazu and a rollicking band of sky pirates, she makes her way to the ruins of the once-great civilization. Sheeta and Pazu must outwit the evil Muska, who plans to use Laputa's science to make himself ruler of the world.",
            "director": "Hayao Miyazaki",
            "producer": "Isao Takahata",
            "release_date": "1986",
            "running_time": "124",
            "rt_score": "95",
            "people": [
                "https://ghibliapi.herokuapp.com/people/598f7048-74ff-41e0-92ef-87dc1ad980a9",
                "https://ghibliapi.herokuapp.com/people/fe93adf2-2f3a-4ec4-9f68-5422f1b87c01",
                "https://ghibliapi.herokuapp.com/people/3bc0b41e-3569-4d20-ae73-2da329bf0786",
                "https://ghibliapi.herokuapp.com/people/40c005ce-3725-4f15-8409-3e1b1b14b583",
                "https://ghibliapi.herokuapp.com/people/5c83c12a-62d5-4e92-8672-33ac76ae1fa0",
                "https://ghibliapi.herokuapp.com/people/e08880d0-6938-44f3-b179-81947e7873fc",
                "https://ghibliapi.herokuapp.com/people/2a1dad70-802a-459d-8cc2-4ebd8821248b"
            ],
            "species": [
                "https://ghibliapi.herokuapp.com/species/af3910a6-429f-4c74-9ad5-dfe1c4aa04f2"
            ],
            "locations": [
                "https://ghibliapi.herokuapp.com/locations/"
            ],
            "vehicles": [
                "https://ghibliapi.herokuapp.com/vehicles/4e09b023-f650-4747-9ab9-eacf14540cfb"
            ],
            "url": "https://ghibliapi.herokuapp.com/films/2baf70d1-42bb-4437-b551-e5fed5a87abe"
        },
        {
            "id": "12cfb892-aac0-4c5b-94af-521852e46d6a",
            "title": "Grave of the Fireflies",
            "original_title": "火垂るの墓",
            "original_title_romanised": "Hotaru no haka",
            "image": "https://image.tmdb.org/t/p/w600_and_h900_bestv2/qG3RYlIVpTYclR9TYIsy8p7m7AT.jpg",
            "movie_banner": "https://image.tmdb.org/t/p/original/vkZSd0Lp8iCVBGpFH9L7LzLusjS.jpg",
            "description": "In the latter part of World War II, a boy and his sister, orphaned when their mother is killed in the firebombing of Tokyo, are left to survive on their own in what remains of civilian life in Japan. The plot follows this boy and his sister as they do their best to survive in the Japanese countryside, battling hunger, prejudice, and pride in their own quiet, personal battle.",
            "director": "Isao Takahata",
            "producer": "Toru Hara",
            "release_date": "1988",
            "running_time": "89",
            "rt_score": "97",
            "people": [
                "https://ghibliapi.herokuapp.com/people/"
            ],
            "species": [
                "https://ghibliapi.herokuapp.com/species/af3910a6-429f-4c74-9ad5-dfe1c4aa04f2"
            ],
            "locations": [
                "https://ghibliapi.herokuapp.com/locations/"
            ],
            "vehicles": [
                "https://ghibliapi.herokuapp.com/vehicles/"
            ],
            "url": "https://ghibliapi.herokuapp.com/films/12cfb892-aac0-4c5b-94af-521852e46d6a"
        }
    ]

    """
    
    let responseEqual =
    """
    [
        {
            "id": "2baf70d1-42bb-4437-b551-e5fed5a87abe",
            "title": "Castle in the Sky",
            "original_title": "天空の城ラピュタ",
            "original_title_romanised": "Tenkū no shiro Rapyuta",
            "image": "https://image.tmdb.org/t/p/w600_and_h900_bestv2/npOnzAbLh6VOIu3naU5QaEcTepo.jpg",
            "movie_banner": "https://image.tmdb.org/t/p/w533_and_h300_bestv2/3cyjYtLWCBE1uvWINHFsFnE8LUK.jpg",
            "description": "The orphan Sheeta inherited a mysterious crystal that links her to the mythical sky-kingdom of Laputa. With the help of resourceful Pazu and a rollicking band of sky pirates, she makes her way to the ruins of the once-great civilization. Sheeta and Pazu must outwit the evil Muska, who plans to use Laputa's science to make himself ruler of the world.",
            "director": "Hayao Miyazaki",
            "producer": "Isao Takahata",
            "release_date": "1986",
            "running_time": "124",
            "rt_score": "95",
            "people": [
                "https://ghibliapi.herokuapp.com/people/598f7048-74ff-41e0-92ef-87dc1ad980a9",
                "https://ghibliapi.herokuapp.com/people/fe93adf2-2f3a-4ec4-9f68-5422f1b87c01",
                "https://ghibliapi.herokuapp.com/people/3bc0b41e-3569-4d20-ae73-2da329bf0786",
                "https://ghibliapi.herokuapp.com/people/40c005ce-3725-4f15-8409-3e1b1b14b583",
                "https://ghibliapi.herokuapp.com/people/5c83c12a-62d5-4e92-8672-33ac76ae1fa0",
                "https://ghibliapi.herokuapp.com/people/e08880d0-6938-44f3-b179-81947e7873fc",
                "https://ghibliapi.herokuapp.com/people/2a1dad70-802a-459d-8cc2-4ebd8821248b"
            ],
            "species": [
                "https://ghibliapi.herokuapp.com/species/af3910a6-429f-4c74-9ad5-dfe1c4aa04f2"
            ],
            "locations": [
                "https://ghibliapi.herokuapp.com/locations/"
            ],
            "vehicles": [
                "https://ghibliapi.herokuapp.com/vehicles/4e09b023-f650-4747-9ab9-eacf14540cfb"
            ],
            "url": "https://ghibliapi.herokuapp.com/films/2baf70d1-42bb-4437-b551-e5fed5a87abe"
        },
        {
            "id": "12cfb892-aac0-4c5b-94af-521852e46d6a",
            "title": "Grave of the Fireflies",
            "original_title": "火垂るの墓",
            "original_title_romanised": "Hotaru no haka",
            "image": "https://image.tmdb.org/t/p/w600_and_h900_bestv2/qG3RYlIVpTYclR9TYIsy8p7m7AT.jpg",
            "movie_banner": "https://image.tmdb.org/t/p/original/vkZSd0Lp8iCVBGpFH9L7LzLusjS.jpg",
            "description": "In the latter part of World War II, a boy and his sister, orphaned when their mother is killed in the firebombing of Tokyo, are left to survive on their own in what remains of civilian life in Japan. The plot follows this boy and his sister as they do their best to survive in the Japanese countryside, battling hunger, prejudice, and pride in their own quiet, personal battle.",
            "director": "Isao Takahata",
            "producer": "Toru Hara",
            "release_date": "1988",
            "running_time": "89",
            "rt_score": "97",
            "people": [
                "https://ghibliapi.herokuapp.com/people/"
            ],
            "species": [
                "https://ghibliapi.herokuapp.com/species/af3910a6-429f-4c74-9ad5-dfe1c4aa04f2"
            ],
            "locations": [
                "https://ghibliapi.herokuapp.com/locations/"
            ],
            "vehicles": [
                "https://ghibliapi.herokuapp.com/vehicles/"
            ],
            "url": "https://ghibliapi.herokuapp.com/films/12cfb892-aac0-4c5b-94af-521852e46d6a"
        },
        {
            "id": "790e0028-a31c-4626-a694-86b7a8cada40",
            "title": "Earwig and the Witch",
            "original_title": "アーヤと魔女",
            "original_title_romanised": "Āya to Majo",
            "image": "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/sJhFtY3eHuvvACaPpxpzdCLQqpQ.jpg",
            "movie_banner": "https://www.themoviedb.org/t/p/original/qMxpGzmmnY1jLd4p7EhhoW43wWF.jpg",
            "description": "An orphan girl, Earwig, is adopted by a witch and comes home to a spooky house filled with mystery and magic.",
            "director": "Gorō Miyazaki",
            "producer": "Toshio Suzuki",
            "release_date": "2021",
            "running_time": "82",
            "rt_score": "30",
            "people": [
                "https://ghibliapi.herokuapp.com/people/"
            ],
            "species": [
                "https://ghibliapi.herokuapp.com/species/"
            ],
            "locations": [
                "https://ghibliapi.herokuapp.com/locations/"
            ],
            "vehicles": [
                "https://ghibliapi.herokuapp.com/vehicles/"
            ],
                "url": "https://ghibliapi.herokuapp.com/films/790e0028-a31c-4626-a694-86b7a8cada40"
        }
    ]

    """
    
    let responseMore =
    """
    [
        {
            "id": "2baf70d1-42bb-4437-b551-e5fed5a87abe",
            "title": "Castle in the Sky",
            "original_title": "天空の城ラピュタ",
            "original_title_romanised": "Tenkū no shiro Rapyuta",
            "image": "https://image.tmdb.org/t/p/w600_and_h900_bestv2/npOnzAbLh6VOIu3naU5QaEcTepo.jpg",
            "movie_banner": "https://image.tmdb.org/t/p/w533_and_h300_bestv2/3cyjYtLWCBE1uvWINHFsFnE8LUK.jpg",
            "description": "The orphan Sheeta inherited a mysterious crystal that links her to the mythical sky-kingdom of Laputa. With the help of resourceful Pazu and a rollicking band of sky pirates, she makes her way to the ruins of the once-great civilization. Sheeta and Pazu must outwit the evil Muska, who plans to use Laputa's science to make himself ruler of the world.",
            "director": "Hayao Miyazaki",
            "producer": "Isao Takahata",
            "release_date": "1986",
            "running_time": "124",
            "rt_score": "95",
            "people": [
                "https://ghibliapi.herokuapp.com/people/598f7048-74ff-41e0-92ef-87dc1ad980a9",
                "https://ghibliapi.herokuapp.com/people/fe93adf2-2f3a-4ec4-9f68-5422f1b87c01",
                "https://ghibliapi.herokuapp.com/people/3bc0b41e-3569-4d20-ae73-2da329bf0786",
                "https://ghibliapi.herokuapp.com/people/40c005ce-3725-4f15-8409-3e1b1b14b583",
                "https://ghibliapi.herokuapp.com/people/5c83c12a-62d5-4e92-8672-33ac76ae1fa0",
                "https://ghibliapi.herokuapp.com/people/e08880d0-6938-44f3-b179-81947e7873fc",
                "https://ghibliapi.herokuapp.com/people/2a1dad70-802a-459d-8cc2-4ebd8821248b"
            ],
            "species": [
                "https://ghibliapi.herokuapp.com/species/af3910a6-429f-4c74-9ad5-dfe1c4aa04f2"
            ],
            "locations": [
                "https://ghibliapi.herokuapp.com/locations/"
            ],
            "vehicles": [
                "https://ghibliapi.herokuapp.com/vehicles/4e09b023-f650-4747-9ab9-eacf14540cfb"
            ],
            "url": "https://ghibliapi.herokuapp.com/films/2baf70d1-42bb-4437-b551-e5fed5a87abe"
        },
        {
            "id": "12cfb892-aac0-4c5b-94af-521852e46d6a",
            "title": "Grave of the Fireflies",
            "original_title": "火垂るの墓",
            "original_title_romanised": "Hotaru no haka",
            "image": "https://image.tmdb.org/t/p/w600_and_h900_bestv2/qG3RYlIVpTYclR9TYIsy8p7m7AT.jpg",
            "movie_banner": "https://image.tmdb.org/t/p/original/vkZSd0Lp8iCVBGpFH9L7LzLusjS.jpg",
            "description": "In the latter part of World War II, a boy and his sister, orphaned when their mother is killed in the firebombing of Tokyo, are left to survive on their own in what remains of civilian life in Japan. The plot follows this boy and his sister as they do their best to survive in the Japanese countryside, battling hunger, prejudice, and pride in their own quiet, personal battle.",
            "director": "Isao Takahata",
            "producer": "Toru Hara",
            "release_date": "1988",
            "running_time": "89",
            "rt_score": "97",
            "people": [
                "https://ghibliapi.herokuapp.com/people/"
            ],
            "species": [
                "https://ghibliapi.herokuapp.com/species/af3910a6-429f-4c74-9ad5-dfe1c4aa04f2"
            ],
            "locations": [
                "https://ghibliapi.herokuapp.com/locations/"
            ],
            "vehicles": [
                "https://ghibliapi.herokuapp.com/vehicles/"
            ],
            "url": "https://ghibliapi.herokuapp.com/films/12cfb892-aac0-4c5b-94af-521852e46d6a"
        },
        {
            "id": "790e0028-a31c-4626-a694-86b7a8cada40",
            "title": "Earwig and the Witch",
            "original_title": "アーヤと魔女",
            "original_title_romanised": "Āya to Majo",
            "image": "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/sJhFtY3eHuvvACaPpxpzdCLQqpQ.jpg",
            "movie_banner": "https://www.themoviedb.org/t/p/original/qMxpGzmmnY1jLd4p7EhhoW43wWF.jpg",
            "description": "An orphan girl, Earwig, is adopted by a witch and comes home to a spooky house filled with mystery and magic.",
            "director": "Gorō Miyazaki",
            "producer": "Toshio Suzuki",
            "release_date": "2021",
            "running_time": "82",
            "rt_score": "30",
            "people": [
                "https://ghibliapi.herokuapp.com/people/"
            ],
            "species": [
                "https://ghibliapi.herokuapp.com/species/"
            ],
            "locations": [
                "https://ghibliapi.herokuapp.com/locations/"
            ],
            "vehicles": [
                "https://ghibliapi.herokuapp.com/vehicles/"
            ],
                "url": "https://ghibliapi.herokuapp.com/films/790e0028-a31c-4626-a694-86b7a8cada40"
        },
        {
            "id": "d868e6ec-c44a-405b-8fa6-f7f0f8cfb500",
            "title": "The Red Turtle",
            "original_title": "レッドタートル ある島の物語",
            "original_title_romanised": "Reddotātoru aru shima no monogatari",
            "image": "https://image.tmdb.org/t/p/w600_and_h900_bestv2/wOBU3SLjQ9358Km9YWYasPZyebp.jpg",
            "movie_banner": "https://image.tmdb.org/t/p/original/kjXdW5H3myRBmTMYgKayjphr2FA.jpg",
            "description": "A man set adrift by a storm wakes up on a beach. He discovers that he is on a deserted island with plenty of fresh water, fruit and a dense bamboo forest. He builds a raft from bamboo and attempts to sail away, but his raft is destroyed by an unseen monster in the sea, forcing him back to the island. He tries again with another, larger raft, but is again foiled by the creature. A third attempt again ends with the raft destroyed, but this time he is confronted by a giant red turtle, which stares at him, and forces him back to the island.",
            "director": "Michaël Dudok de Wit",
            "producer": "Toshio Suzuki, Isao Takahata, Vincent Maraval, Pascal Caucheteux, Grégoire Sorlat",
            "release_date": "2016",
            "running_time": "80",
            "rt_score": "93",
            "people": [
                "https://ghibliapi.herokuapp.com/people/"
            ],
            "species": [
                "https://ghibliapi.herokuapp.com/species/"
            ],
            "locations": [
                "https://ghibliapi.herokuapp.com/locations/"
            ],
            "vehicles": [
                "https://ghibliapi.herokuapp.com/vehicles/"
            ],
            "url": "https://ghibliapi.herokuapp.com/films/d868e6ec-c44a-405b-8fa6-f7f0f8cfb500"
        }
    ]

    """
    
    func fetchMovies<T: Decodable>(urlString: String) -> AnyPublisher<T, Error> {
        let response = getGhibliMoviesFromText(response: urlString)
        return Just(response as! T)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func getGhibliMoviesFromText(response: String) -> Ghibli? {
        do {
            let jsonData = Data(response.utf8)
            let movies = try JSONDecoder().decode(Ghibli.self, from: jsonData)
            return movies
        } catch {
            return nil
        }
    }
    
    func getMoviesFromText(response: String) -> [PersonalizedMovie]? {
        do {
            let jsonData = Data(response.utf8)
            let movies = try JSONDecoder().decode(Ghibli.self, from: jsonData)
            var personalizedMovies = [PersonalizedMovie]()
            
            for movie in movies {
                let personalizedMovie = PersonalizedMovie(ghibliMovie: movie, state: .none)
                personalizedMovies.append(personalizedMovie)
            }
            
            return personalizedMovies
            
        } catch {
            return nil
        }
    }
}
