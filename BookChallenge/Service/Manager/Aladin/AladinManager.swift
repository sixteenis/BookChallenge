//
//  AladinManager.swift
//  BookChallenge
//
//  Created by 박성민 on 8/17/24.
//

import Foundation

import RxSwift
import Alamofire

final class AladinManager {
    static let shared = AladinManager()
    private init() {}
    
    // MARK: - 베스트 셀러 통신
    func getBestseller() -> Single<Result<[BookDTO],AladinError>> {
        return Single.create { observer -> Disposable in
            do {
                let request = try AladinRouter.fetchBestseller.asURLRequest()
                AF.request(request)
                    .responseDecodable(of: BestsellerDTO.self) { response in
                        switch response.result {
                        case .success(let data):
                            observer(.success(.success(data.item)))
                        case .failure(_):
                            switch response.response?.statusCode {
                            case 400:
                                observer(.success(.failure(.network)))
                            case 401:
                                observer(.success(.failure(.network)))
                            default:
                                observer(.success(.failure(.network)))
                            }
                            
                        }
                    }
                
            } catch {
                print(error)
            }
            return Disposables.create()
        }
    }
    // MARK: - 책 제목, 작가를 통해 책 검색하기
    func getBookLists(keyword: String, page: Int) -> Single<Result<SearchBookDTO, AladinError>> {
        return Single.create { observer -> Disposable in
            do {
                let request = try AladinRouter.searchBook(keyword: keyword, page: page).asURLRequest()
                AF.request(request)
                    .responseDecodable(of: SearchBookDTO.self) { response in
                        switch response.result {
                        case .success(let data):
                            observer(.success(.success(data)))
                        case .failure(_):
                            switch response.response?.statusCode {
                            case 400:
                                observer(.success(.failure(.network)))
                            case 401:
                                observer(.success(.failure(.network)))
                            default:
                                observer(.success(.failure(.network)))
                            }
                            
                        }
                    }
                
            } catch {
                print(error)
            }
            return Disposables.create()
        }
    }
    // MARK: - id값을 통해 디테일한 책 데이터 가져오기
    func getBookDetail(id: String) -> Single<Result<DetailBookDTO, AladinError>> {
        return Single.create { observer -> Disposable in
            do {
                let request = try AladinRouter.searchBookId(itemId: id).asURLRequest()
                AF.request(request)
                    .responseDecodable(of: SearchBookWithIDDTO.self) { response in
                        switch response.result {
                        case .success(let data):
                            observer(.success(.success(data.item[0])))
                        case .failure(_):
                            switch response.response?.statusCode {
                            case 400:
                                observer(.success(.failure(.network)))
                            case 401:
                                observer(.success(.failure(.network)))
                            default:
                                observer(.success(.failure(.network)))
                            }
                            
                        }
                    }
                
            } catch {
                print(error)
            }
            return Disposables.create()
        }
    }
}
