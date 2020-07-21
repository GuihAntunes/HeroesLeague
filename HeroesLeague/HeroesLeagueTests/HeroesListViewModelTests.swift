//
//  HeroesListViewModelTests.swift
//  HeroesLeagueTests
//
//  Created by Guilherme Antunes Ferreira on 21/07/2020.
//  Copyright © 2020 Guihsoft. All rights reserved.
//

import XCTest
@testable import HeroesLeague

class HeroesListViewModelTests: XCTestCase {
    
    class MockedView: HeroesListPresentable {
        
        var reloadListCalled = false
        var stopLoadingCalled = false
        var startLoadingCalled = false
        var showErrorCalled = false
        
        func reloadList() {
            reloadListCalled = true
            stopLoading()
        }
        
        func stopLoading() {
            stopLoadingCalled = true
        }
        
        func startLoading() {
            startLoadingCalled = true
        }
        
        func showError(_ error: Error) {
            showErrorCalled = true
        }
        
        
    }
    
    class MockedCoordinator: AppCoordinatorProtocol {
           var presentNextStepCalled = false
           var presentPreviousStepCalled = false
           
           func presentNextStep() {
               presentNextStepCalled = true
           }
           
           func presentPreviousStep() {
               presentPreviousStepCalled = true
           }
           
           
       }
    
    class MockedRepository: HeroesRepositoryProtocol {
        var fetchHeroesListCalled = false
        var fetchHeroDetailsCalled = false
        var searchHeroCalled = false
        var saveHeroLocallyCalled = false
        var deleteHeroLocallyCalled = false
        var retriveFavoritesCalled = false
        var shouldGoToErrorFlow = false
        
        func fetchHeroesList(lastIndex index: Int, completion: @escaping RequesterCompletion<MarvelCharacterListResponse>) {
            fetchHeroesListCalled = true
            
            if shouldGoToErrorFlow {
                completion(nil, CustomError.APIError("Some error"))
            } else {
                completion(TestsUtils().getMockedResponse("HeroListResponseExample"), nil)
            }
        }
        
        func fetchHeroDetails(forHero heroId: Int, completion: @escaping RequesterCompletion<[MarvelCharacterDetailsResponse?]>) {
            fetchHeroDetailsCalled = true
        }
        
        func searchHero(withName name: String, completion: @escaping RequesterCompletion<MarvelCharacterListResponse>) {
            searchHeroCalled = true
            
            if shouldGoToErrorFlow {
                completion(nil, CustomError.APIError("Some error"))
            } else {
                completion(.init(code: 0, status: "", copyright: "", data: .init(offset: 0, limit: 0, total: 0, count: 0, results: TestsUtils().getMockedResponse("HeroListResponseExample")?.data?.results)), nil)
            }
        }
        
        func saveHeroLocally(_ hero: Hero, details: [HeroAppearance]?, withThumbnail thumbnail: UIImage?) {
            saveHeroLocallyCalled = true
        }
        
        func deleteHeroLocally(_ hero: Hero) {
            deleteHeroLocallyCalled = true
        }
        
        func retriveFavorites() -> [Hero]? {
            retriveFavoritesCalled = true
            return nil
        }
    }
    
    var subject: HeroesListViewModel!
    var mockedCoordinator: MockedCoordinator!
    var mockedRepository: MockedRepository!
    var mockedView: MockedView!
    
    override func setUpWithError() throws {
        mockedCoordinator = MockedCoordinator()
        mockedRepository = MockedRepository()
        mockedView = MockedView()
        subject = HeroesListViewModel()
        subject.coordinator = mockedCoordinator
        subject.selectedHero = nil
        subject.view = mockedView
        subject.repository = mockedRepository
        
    }

    override func tearDownWithError() throws {
        subject = nil
    }
    
    func testingLoadHeroesMethod() throws {
        XCTAssertNotNil(subject)
        XCTAssert(subject.lastIndexFetched == 0, "Wrong initial value for index")
        
        subject.loadHeroes()
        
        XCTAssert(subject.heroes.count == 1, "Failed parsing test")
        XCTAssertFalse(subject.wasSearching, "Wrong treatment for search model treatment")
        XCTAssertTrue(mockedView.reloadListCalled, "List update wasn't called")
        XCTAssertTrue(mockedView.startLoadingCalled, "Loader wasn't showned")
        XCTAssertTrue(mockedView.stopLoadingCalled, "Loader wasn't hidden")

    }
    
    func testingListConfiguration() throws {
        XCTAssertNotNil(subject)
        XCTAssert(subject.lastIndexFetched == 0, "Wrong initial value for index")
        
        subject.loadHeroes()
        XCTAssert(subject.getTitle() == "Heroes League", "Wrong screen title")
        XCTAssert(subject.numberOfSections() == 1, "Wrong list section configuration")
        XCTAssert(subject.numberOfItemsInSection(0) == 1, "Wrong list rows configuration")
        XCTAssertNotNil(subject.getHero(atIndexPath: IndexPath(row: 0, section: 0)), "Failed retriving list configuration item")
        
    }
    
    func testingItemSelectionLogic() throws {
        XCTAssertNotNil(subject)
        XCTAssert(subject.lastIndexFetched == 0, "Wrong initial value for index")
        
        subject.loadHeroes()
        
        subject.selectHero(atIndexPath: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(subject.selectedHero, "Not selecting hero")
        XCTAssert(subject.selectedHero?.name == "Spider-Man", "Selecting wrong item on the list")
    }
    
    func testingSearchHeroLogic() throws {
        XCTAssertNotNil(subject)
        XCTAssert(subject.lastIndexFetched == 0, "Wrong initial value for index")
        XCTAssertFalse(subject.wasSearching, "Wrong searching control flag initial value")
        XCTAssertFalse(mockedView.reloadListCalled, "Wrong test setup for view")
        XCTAssertFalse(mockedView.startLoadingCalled, "Wrong test setup for view")
        XCTAssertFalse(mockedView.stopLoadingCalled, "Wrong test setup for view")
        
        subject.searchHero(withName: "")
        XCTAssertTrue(subject.wasSearching, "Wrong searching control flag value")
        XCTAssertTrue(mockedView.reloadListCalled, "List update wasn't called")
        XCTAssertTrue(mockedView.startLoadingCalled, "Loader wasn't showned")
        XCTAssertTrue(mockedView.stopLoadingCalled, "Loader wasn't hidden")
        
    }
    
}

class TestsUtils {
    
    func getMockedResponse(_ fileName: String) -> MarvelCharacterListResponse? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json"), let data = try? Data(contentsOf: url) else {
            return nil
        }
        
        guard let model = try? JSONDecoder().decode(MarvelCharacterListResponse.self, from: data) else {
            return nil
        }
        
        return model
    }
    
}
