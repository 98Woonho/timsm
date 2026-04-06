# 🚌 TIMSM

Flutter + Spring Boot 기반 TIMS 모바일 앱

## 🛠️ 기술 스택 (Tech Stack)

### Frontend
* **Framework:** Flutter
* **Language:** Dart
* **Key Packages:** `http` (REST API 통신)

### Backend
* **Framework:** Spring Boot 
* **Language:** Java 8
* **IDE:** IntelliJ IDEA
* **Database Access:** MyBatis
* **Database:** Oracle 10g

---

## 📂 프로젝트 구조 (Monorepo)

본 프로젝트는 프론트엔드와 백엔드를 하나의 Repository에서 관리합니다.

```text
/tims-project
├── /flutter        # 프론트엔드 (Android Studio에서 이 폴더를 여세요)
└── /springboot     # 백엔드 (IntelliJ IDEA에서 이 폴더를 여세요)
```

---
 
## ⚙️ 개발 환경 구축
 
### 사전 설치 항목
- Flutter SDK
- Android Studio
- IntelliJ IDEA
- Git
 
---

### 📌 프로젝트 클론
 
```bash
git clone https://github.com/98Woonho/timsm.git
cd timsm
```

---
 
### 📌 Frontend 설정 (Flutter)

#### 1. 기본 세팅
1. https://codingapple.com/unit/flutter-install-on-windows-and-mac/
2. https://minibcake.tistory.com/556

#### 2. 패키지 다운로드
1. Android Studio에서 `flutter` 폴더를 엽니다.
2. 하단 터미널을 열고 필요한 패키지를 다운로드합니다.
   ```bash
   flutter pub get
   ```
 
---

### 📌 Backend 설정 (Spring Boot)
 
#### 1. application.properties 설정
 
```bash
# application.properties.sample을 복사해서 application.properties 생성
cp springboot/src/main/resources/application.properties.sample \
   springboot/src/main/resources/application.properties
```
 
#### 2. application.properties 값 입력
 
```properties
spring.datasource.url=jdbc:oracle:thin:@{서버IP}:1521:{SID}
spring.datasource.driver-class-name=oracle.jdbc.OracleDriver
spring.datasource.username={DB 계정}
spring.datasource.password={DB 비밀번호}
```
 
> ⚠️ `application.properties`는 보안상 git에 포함되지 않습니다.
> 반드시 `.sample` 파일을 참고해서 직접 생성해주세요.
 
#### 3. ojdbc8.jar 확인
 
```
springboot/libs/ojdbc8.jar 파일이 있는지 확인
```

---
 
## 📌 새 설정 추가 시 규칙
 
> 팀원 모두가 지켜주세요!
 
`application.properties`에 새 설정을 추가할 경우,
반드시 `application.properties.sample`도 함께 업데이트 후 push 해주세요.
 
```properties
# application.properties.sample 예시
새로추가한.설정.키=     ← 값은 비워두고 키만 추가
```
 
---
