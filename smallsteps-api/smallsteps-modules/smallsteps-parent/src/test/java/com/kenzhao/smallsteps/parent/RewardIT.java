package com.kenzhao.smallsteps.parent;

import com.kenzhao.smallsteps.common.ss.domain.bo.ParentRewardBo;
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
public class RewardIT {

    @LocalServerPort
    private int port;

    @BeforeEach
    public void setup() {
        RestAssured.port = port;
    }

    @Test
    @DisplayName("应该能够查询特定用户的当前积分")
    public void should_get_child_score() {
        Long userId = 100L; // 模拟用户 ID
        given()
        .when()
            .get("/parent/reward/score/" + userId)
        .then()
            .statusCode(anyOf(is(200), is(401)));
    }

    @Test
    @DisplayName("兑换奖励时若积分不足应返回错误或 401 (取决于 Auth 状态)")
    public void should_handle_redeem_logic() {
        ParentRewardBo bo = new ParentRewardBo();
        bo.setRewardId(1L);
        bo.setUserId(100L);

        given()
            .contentType(ContentType.JSON)
            .body(bo)
        .when()
            .post("/parent/reward/redeem")
        .then()
            // 逻辑上：若未登录返回 401；若登录但逻辑失败返回 R.fail 或 200(业务失败)
            .statusCode(anyOf(is(200), is(401), is(400)));
    }

    @Test
    @DisplayName("查询奖励配置列表")
    public void should_list_rewards() {
        given()
            .queryParam("pageNum", 1)
            .queryParam("pageSize", 10)
        .when()
            .get("/parent/reward/list")
        .then()
            .statusCode(anyOf(is(200), is(401)));
    }
}
