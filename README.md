

iOS 12용으로 타게팅 되어 CollectionView 3개를 쓴 화면이 있었습니다, 기존 코드의 회고와 

iOS 13으로 타겟팅을 버전업을 하게 될시 Compositional Layout과 Diffable DataSource 로 리펙토링시 이점을 회고하려고 작성된 리포지토리 입니다.


---
리펙토링 화면 결과 


![컴포지셔널 레이아웃 + 디퍼블데이터소스](https://drive.google.com/uc?export=download&id=1ksFZKCdsTO0Iz9Yxi_wK7pQj9G-LYN_E)

---

Compositional Layout 도입시의 장점

- UX상의 장점  
    1. 데이터가 변경 사항이 있을 경우 애니메이션이 적용되어 UI가 자연스럽게 업데이트되므로 사용자 경험을 해치지 않음

- 성능상의 장점 
    1. Hashable 기반으로 O(n)의 빠른 성능을 가지고 있음
    2. 모든 Cell을 바로 그리는게 아니라 필요한 경우만 메모리에 로드 하므로 메모리 사용상의 장점

- 개발적인 장점
    1. UICollectionView, Data Source 관련 BoilerPlate Code가 대폭감소
    2. Centralized Truth를 사용하기 때문에 UI와 DataSource 간에 Truth가 맞지 않아 크래시나 에러가 발생하는 일이 없음
       -> 예시 : 수강신청된 과목이 1개 였다가 삭제 시 관련 Cell이 View에 남아있는 경우,터치시 비정상 종료 발생의 경우  reloadData() 호출 시점을 놓쳐, 비정상 종료가 발생하는 경우의 수를 줄여줌 !


Compositional Layout 도입시의 단점

- 타게팅 하는 iOS의 버전이 13 이상일 경우에만 지원이 가능하다.
- 기존의 DataSource와 Layout 제어가 아니기에 약간의 러닝커브가 있다.

마무리 : 

- 러닝커브가 있다는 건 극복해야 할 점이지 단점이 아니라고 생각, 
- 서비스 적인 요소들중 장점이 있다면 배워야 한다. 
- 개발적인 요소까지 좋다면 배우지 않을 이유가 없다.
- 다만, Legacy를 지원하는것도 매우매우 중요하다.
