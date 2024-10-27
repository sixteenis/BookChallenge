# 📚 북챌린지
"함께 책을 읽을 사람을 커뮤니티에서 찾아, 완독을 목표로 기록해 보세요!"


<br>


## 📱 **주요 기능**
| 홈 | 서재 | 챌린지방 | 위젯 |
|---------------|---------------|---------------|---------------|
| <img src="https://github.com/user-attachments/assets/a7aa2fb3-b17c-4fcc-a4d3-b6eca505617e" width="200" /> | <img src="https://github.com/user-attachments/assets/82d12107-8c6d-475e-8c1a-fadfd0afc6f8" width="200" /> | <img src="https://github.com/user-attachments/assets/fb9f99f2-2f05-46c1-88f0-a81fb951f7c3" width="200" /> | <img src="https://github.com/user-attachments/assets/6ddae17e-3c3c-42b3-bb28-02478caa33f6" width="200" /> |
> 🔥 이달의 베스트 셀러 책 추천
    
> 🔍 실시간/책 검색으로 챌린지 방 조회 
    
> 👀 챌린지 상세 정보 확인

> ✍️ 챌린지 방 만들기

> 👀 참여 중, 종료된 챌린지 방 조회

> 📝 참여 중인 챌린지 후기 작성

> 👀  참여 중인 유저들의 후기 보기
    
> 📱 최근 챌린지 기록 확인용 위젯
    
  
<br>


## 💻 개발 환경
<p align="left">
<img src ="https://img.shields.io/badge/Swift-5.10-ff69b4">
<img src ="https://img.shields.io/badge/Xcode-15.4-blue">
<img src ="https://img.shields.io/badge/iOS-16.0+-orange">
<br>
    
- **기간**: 2024.08.13 ~ 2024.09.02 (**약 3주**)
- **인원**: iOS 1명, Back-End 1명

    
<br> 

## 🔧 아키텍처 및 기술 스택

- `UIKit` / `RxSwift`/ `SnapKit`
- `MVVM` + `InOut Pattern` 
- `Alamofire` + `Moya` + `Router Pattern`
- `Realm`/`UserDefault`
- `NWNetworkMonitor`  
- `Kingfisher`/  `Toast`/`iamport-ios`
    
<br>    


## 🧰 프로젝트 주요 기술 사항
###  프로젝트 아키텍처

> MVVM + InOut  + RxSwift
    
- RxSwift InOut Pattern을 통한 양방향 데이터 바인딩으로 프로젝트 데이터 흐름 일원화
- Base Class 상속과 associatedtype 형식을 통한 프로젝트 구조의 명시적 정의
- RxSwift Single Tratis를 통한 네트워크 에러 핸들링

<br>

> Alamofire + Moya + NWNetworkMonitor
- URLRequestConvertible과 Router 패턴을 활용한 네트워크 요청 로직 추상화
- DTO(Data Transfer Object)를 활용해 네트워크 계층과 뷰 계층 간의 결합도 최소화
- NWNetworkMonitor를 사용하여 네트워크 연결 상태 모니터링 후 네트워크 연결 유무에 따른 예외 처리 구현
    
    
---
### Carousel Effect 
> Custom CollectionView를 이용한 Carousel Zoom Paging 효과
- Custom CollectionView를 통해 중앙 항목이 강조되는 확대/축소 효과 구현
- scrollViewWillEndDragging 내에서 targetContentOffset을 사용해 셀 포커싱 구현

### 스크롤 가능한 세그먼트 (공사중)

### WidgetKit
> UserDefault(shared container) + reloadTimelines를 이용한 위젯 구현
- UserDefault의 groupShared를 활용하여 위젯과 앱간의 shared container을 통해 데이터 공유
- 앱에서 위젯을 업데이트 해야되는 시점에 reloadTimelines을 호출하여 강제 업데이트 로직 구현

### JWT 토큰 관리
> UserDefault를 통한 Access, Refresh 토큰 관리
- Alamofire의  adapt 메서드에서  토큰 검증이 필요한 네트워크 요청을 자동 분류, 적절한 JWT 토큰을 요청 헤더에 자동으로 추가하는 로직 구현
- retry 메서드를 통해 만료된 Access 토큰을 재발급하고, 갱신된 토큰으로 재시도 자동화 로직 구현

### 결제
- PG사를 웹뷰에 띄워 책 결제 진행
- 사용자의 결제 관련 어뷰징과 결제 검증을 위한 로직 구현

### 페이지네이션
- 커서기반 페이지네이션을 활용한 흐음? 

<br>    

## 🚨 트러블 슈팅 (공사중)
### 토큰 재발급 이슈?
### 위젯 연결 이슈?
### 챌린지방 네트워크 콜 수?

