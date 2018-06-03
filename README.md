## Capstone Project

경기대학교 컴퓨터과학과 201216115 이동건

---

#### 비콘을 활용한 실내 측위 마케팅 솔루션

코엑스나 스타필드와 같은 실내 대형 복합 쇼핑 시설에서 소비자에게는 보유한 카드와 즐겨 찾는 매장에 해당하는 맞춤형 이벤트, 할인 정보를 사업자에게는 구매까지 이어지지 않은 방문자까지 복합 시설 내의 방문자들의 행적, 머문 시간 등의 데이터를 활용하여 이를 마케팅에 이용할 수 있는 솔루션

#### How

비콘은 개별의 고유 신호를 발산한다. 매장마다 비콘을 설치하고 소비자의 디바이스에서 비콘의 신호를 감지한다면 해당 신호가 소비자가 등록한 즐겨 찾는 매장의 비콘 신호와 동일하다면 이를 서버로 전송하여 각종 이벤트 및 할인 정보를 보유한 카드에 맞추어 받아온다. 

이때 사용자가 비콘을 감지한 시간, 비콘과의 근접도 역시 같이 보내기 때문에 이를 서버에 계속해서 기록하여 추후 데이터 활용에 사용한다.

#### 기능

- 즐겨 찾는 매장 등록
  - 서버와의 통신으로 `UserDefaults` 내에 저장 **(구현)**
- 보유하고 있는 카드 등록
  - 서버와의 통신으로 `UserDefaults` 내에 저장 **(구현)**
- 보유한 카드와 즐겨 찾는 매장을 바탕으로 프로모션 정보 알림
  - 영역안으로 들어온 순간 해당 매장이 즐겨 찾는 매장으로 등록되어 있다면 보유하고 있는 카드 정보와 매장 정보를 서버로 보내 이에 해당한 프로모션 코드를 받아와 Local Notification으로 구현 **(구현)**
- 비콘 영역 내/외부 판단 **(구현)**
- 영역안으로 들어온 소비자 판단
  - 영역안으로 들어온 순간 해당 소비자의 정보를 서버로 전송 **(구현)**
- 영역안의 소비자 중 실제 매장(비콘)에 근접한 소비자 판단 - 실제 방문까지 이어진 방문자로 정의
  - 영역안에서 특히 매장(비콘)과의 근접도가 `.immediate` , `.near` , `.far` 중 `.immediate` (가장 가까운 단계) 해당하는 소비자는 모두 매장에 방문한 소비자로 간주 **(구현)**
- 신호의 튕김 현상 보완
  - 신호의 세기에 따라 순간적으로 실제로 방문까지 이어지지 않은 매장을 근접한 매장이라 판단할 수 있음
  - 정상적인 방문이라면 `.far` -> `.near` -> `.immediate` 순으로 근접도의 변화가 있어야 함. 해당 매장을 벗어날 때는 반대로 `.immediate` -> `.near` -> `.far` 순으로 근접도가 변경되어야 함.
  - 그렇기 때문에 이전 근접도가 `.far` 인데 현재 근접도가 `.immediate`라면 이는 신호의 튕김 현상이라 간주 서버로 방문 소비자로 전송하지 않음. **(미구현 - 설계만)**
- 영역 중첩에 따른 속한 영역 우선 순위
  - 근접도에 따른 가중치를 두어 중첩되어 속한 영역 중 어느 비콘에 보다 근접했는지를 판단 **(미구현 - 설계만)**

#### Implementation

비콘이 전송하는 신호에는 UUID, minor, major 값이 담겨있음. 비콘과 디바이스는 양방향 통신이 아닌 단방향으로 어떤 정보를 전송하는 것이 아닌 단순히 신호만을 전송함. 해당 신호에 대한 정보를 서버에 저장해두고 이를 바탕으로 신호가 감지되었을 때 알맞게 처리한다.

iOS Core Location 프레임워크를 활용하여 비콘의 영역을 등록하고 이를 추적. 기본적으로 iOS는 최대 20개의 영역까지만 등록할 수 있음. 그렇기 때문에 비콘 각각을 영역으로 삼지 않고 코엑스, 스타필드와 같은 복합 시설 전체를 하나의 영역으로 설정

그렇다면 스타필드 내의 모든 매장은 같은 영역 값을 갖고 이는 비콘의 UUID에 해당, 즉 한 스타필드 내의 모든 매장의 UUID는 동일. 각 매장을 구분하는 것은 비콘의 minor 값과 major 값으로 식별.

비콘의 신호를 감지는 두 단계에 걸쳐서 이루어짐

- **Monitoring** - 비콘의 영역을 판단하는 행위로 디바이스 주변의 비콘 영역을 스캔한다. 그리고 비콘 영역의 내/외부를 판단함. 비콘의 영역안에 들어온 순간과 나가는 순간에 행동을 정의해줄 수 있음
  - 영역의 모니터링은 Core Location을 활용함. 영역 모니터링을 위해서는 앱의 사용과 상관없이 위치 서비스를 항상 사용하기 위한 권한 요청이 필요함.
  - 또한 백그라운드에서 위치의 갱신도 이루어져야 하기 때문에 해당 기능도 프로젝트 내에서 설정이 선행되어야 함.
  - 관련 메소드 및 코드
    - `func startMonitoring(for region: CLRegion)` - 원하는 영역을 Monitoring
    -  `locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion)` - 영역 안에 들어온 순간에 호출되는 메소드
    - `func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion)` -  영역을 벗어난 순간에 호출되는 메소드
    - `func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion)` - 영역의 내부인지 외부인지를 판단하는 메소드, 모니터링을 시작한 순간에 이미 영역 안이라면 위의 `didEnterRegion` 은 호출되지 않고 `didDetermineState`가 먼저 호출됨.  `state`가 `.inside`면 Ranging을 시작하고 `.outside`가 되면 Ranging을 멈추는 코드를 이 메소드안에 구현
    - 
- **Ranging** - 비콘의 영역 안에서 비콘과의 근접도를 측정하는 행위.
  - 이 행위는 위치에 따른 근접도가 아닌 감지되는 신호의 세기에 따라 달라지기 때문에 거리에 대한 정보를 사용자에게 제공해주는 것은 옳지 않음. 실제로 신호의 세기에 따라 더 가까운 비콘이 더 멀다고 측정되는 경우가 간간히 있음.
  - 관련 메소드 및 코드
    - `func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion)` - Ranging하고 있는 비콘들을 매개변수로 받기 때문에 이를 활용하여 코드를 작성할 수 있음.
    -  `beacons.first `를 통해 가장 가까운 비콘에 대한 행위를 정의해줄 수 있다.
    -  `nearestBeacon.proximity ` 을 통해 비콘과의 근접도를 판단할 수 있다. `.immediate`, `.near` , `.far` 순으로 근접한 근접도를 판단함.

**참고자료**

- [Determining the proximity to an iBeacon](https://developer.apple.com/documentation/corelocation/determining_the_proximity_to_an_ibeacon)
- [Region Monitoring and iBeacon](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/LocationAwarenessPG/RegionMonitoring/RegionMonitoring.html#//apple_ref/doc/uid/TP40009497-CH9-SW1)