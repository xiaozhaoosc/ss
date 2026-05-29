//package com.kenzhao.smallsteps;
//
//import io.restassured.RestAssured;
//import org.junit.jupiter.api.BeforeEach;
//import org.junit.jupiter.api.Tag;
//import org.junit.jupiter.api.Test;
//import org.springframework.boot.test.context.SpringBootTest;
//import org.springframework.boot.test.web.server.LocalServerPort;
//
//import static io.restassured.RestAssured.given;
//import static org.hamcrest.Matchers.anyOf;
//import static org.hamcrest.Matchers.is;
//
//@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
//@Tag("dev")
//public class HealthCheckIT sq
//    @LocalServerPort
//    private int port;
//
//    @BeforeEach
//    public void setup() {
//        RestAssured.port = port;
//    }
//
//    @Test
//    public void should_return_200_or_401_on_root_api() {
//        // 由于有 Sa-Token 保护，根路径可能返回 401，但 API 必须是存活的
//        given()
//        .when()
//            .get("/")
//        .then()
//            .statusCode(anyOf(is(200), is(401)));
//    }
//}
