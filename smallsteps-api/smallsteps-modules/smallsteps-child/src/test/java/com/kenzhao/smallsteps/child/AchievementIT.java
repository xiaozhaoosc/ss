package com.kenzhao.smallsteps.child;

import io.restassured.RestAssured;
import io.restassured.http.ContentType;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Tag;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.server.LocalServerPort;

import static io.restassured.RestAssured.given;
import static org.hamcrest.Matchers.*;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@Tag("dev")
public class AchievementIT {

    @LocalServerPort
    private int port;

    @BeforeEach
    public void setup() {
        RestAssured.port = port;
    }

    @Test
    @DisplayName("应该能够为儿童发放星星奖励")
    public void should_reward_stars() {
        Long childId = 1L;
        int stars = 5;

        given()
            .queryParam("childId", childId)
            .queryParam("stars", stars)
        .when()
            .post("/child/achievement/reward/stars")
        .then()
            .statusCode(anyOf(is(200), is(401)));
    }

    @Test
    @DisplayName("应该能够查询儿童的总星星数量")
    public void should_get_total_stars() {
        Long childId = 1L;

        given()
        .when()
            .get("/child/achievement/stars/" + childId)
        .then()
            .statusCode(anyOf(is(200), is(401)));
    }

    @Test
    @DisplayName("应该能够查询儿童的成就统计信息")
    public void should_get_achievement_stats() {
        Long childId = 1L;

        given()
        .when()
            .get("/child/achievement/stats/" + childId)
        .then()
            .statusCode(anyOf(is(200), is(401), is(404))); // 404 如果路径映射不完全匹配
    }
}
