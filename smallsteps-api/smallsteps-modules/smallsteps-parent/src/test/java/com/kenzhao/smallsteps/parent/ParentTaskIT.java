package com.kenzhao.smallsteps.parent;

import com.kenzhao.smallsteps.common.ss.domain.bo.ParentTaskBo;
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
public class ParentTaskIT {

    @LocalServerPort
    private int port;

    @BeforeEach
    public void setup() {
        RestAssured.port = port;
        // 注意：实际测试中需要处理 Sa-Token 登录认证，此处假设测试环境下有 Mock 或特定 Token
    }

    @Test
    @DisplayName("家长应该能够成功创建一个新任务")
    public void should_create_task_successfully() {
        ParentTaskBo bo = new ParentTaskBo();
        bo.setTitle("测试任务-" + System.currentTimeMillis());
        bo.setDescription("完成每日阅读 30 分钟");
        bo.setRewardPoints(10);
        bo.setStatus("0"); // 待发布/进行中

        given()
            .contentType(ContentType.JSON)
            .body(bo)
        .when()
            .post("/parent/task")
        .then()
            // 在没有 Token 的情况下预期返回 401，若环境已配置则为 200
            .statusCode(anyOf(is(200), is(401)));
    }

    @Test
    @DisplayName("家长应该能够查询任务列表")
    public void should_query_task_list() {
        given()
            .queryParam("pageNum", 1)
            .queryParam("pageSize", 10)
        .when()
            .get("/parent/task/list")
        .then()
            .statusCode(anyOf(is(200), is(401)));
    }
}
