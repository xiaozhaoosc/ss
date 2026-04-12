# SATS-API: Backend Automation Standards

## 1. 技术栈
- **测试框架**: JUnit 5 (jupiter)
- **模拟框架**: Mockito
- **API 验证**: RestAssured (RESTful 接口测试首选)
- **断言库**: AssertJ (流式断言，代码更具可读性)
- **报告生成**: Allure Framework

## 2. 测试分类与规范

### 2.1 单元测试 (Unit Tests)
- **存放位置**: `src/test/java/...` 下与源码包结构一致。
- **命名规范**: `[ClassName]Test.java`。
- **原则**: 独立执行，不依赖数据库或网络，使用 Mockito 隔离外部依赖。
- **示例**:
  ```java
  @ExtendWith(MockitoExtension.class)
  class UserServiceTest {
      @Mock private UserRepository userRepository;
      @InjectMocks private UserServiceImpl userService;
      // ...
  }
  ```

### 2.2 集成测试 (Integration Tests)
- **存放位置**: `src/test/java/...`
- **命名规范**: `[Feature]IT.java`。
- **容器化测试**: 使用 **Testcontainers** 启动隔离的 PostgreSQL 容器进行验证。
- **API 验证**: 使用 RestAssured 调用 Controller 层。
  ```java
  @SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
  class AuthIT {
      @Test
      void should_login_successfully() {
          given().body(loginReq).when().post("/api/login").then().statusCode(200);
      }
  }
  ```

## 3. 测试覆盖率 (Coverage)
- 使用 **JaCoCo** 在构建期间生成报告。
- 强制要求 Service 层逻辑覆盖率达到 80%+。

## 4. 测试报告集成
- 每个测试用例应使用 `@Severity`, `@Description`, `@Step` 等 Allure 注解，以便生成详细的测试分析。
