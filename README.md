# 🚌 TIMSM

Flutter + Spring Boot 기반 TIMS 모바일 앱

## 🛠️ 기술 스택 (Tech Stack)

### Frontend
* **Framework:** Flutter
* **Language:** Dart

### Backend
* **Framework:** Spring Boot 
* **Language:** Java 8
* **Database Access:** MyBatis
* **Database:** Oracle 10g

---

## 📂 프로젝트 구조 (Monorepo)

본 프로젝트는 프론트엔드와 백엔드를 하나의 Repository에서 관리합니다.

```text
/tims-project
├── /flutter        # 프론트엔드
└── /springboot     # 백엔드
```
- `Android Studio(flutter)`와 `intellij(springboot)`, 2개의 IDE로 개발하는 방법이 있고, `VS Code` 하나로 개발하는 방법이 있습니다. `VS Code` 하나로 개발하는 방법은 맨 하단에 작성되어 있습니다.

---
 
## ⚙️ 개발 환경 구축
 
### 사전 설치 항목
- Flutter SDK
- Android Studio
- VS Code
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
1. VS Code에서 `flutter` 폴더를 엽니다.
2. 하단 터미널을 열고 필요한 패키지를 다운로드합니다.
   ```bash
   flutter pub get
   flutter pub add go_router
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

## 💻 flutter, spring boot 함께 실행하는 방법

별도의 터미널 명령어를 입력할 필요 없이 VS Code의 기능을 활용합니다.

1. **VS Code 확장 프로그램 설치**
 - Extension Pack for Java
 - Spring Boot Extension Pack
 - Gradle for Java
2. **에뮬레이터 실행**: 하단 상태 표시줄에서 실행할 기기(Android Emulator 또는 Web)를 선택합니다.
3. **실행 및 디버그 탭 이동**: `Ctrl + Shift + D`를 누릅니다.
4. **복합 실행 선택**: 상단 드롭다운 메뉴에서 **`풀스택 동시 실행`**을 선택합니다.
5. **시작**: `F5` 키를 누르면 백엔드와 프론트엔드가 순차적으로 실행됩니다.

---
