package com.kenzhao.smallsteps.device;

import io.restassured.RestAssured;
import io.restassured.http.ContentType;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Tag;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.server.LocalServerPort;

import java.util.HashMap;
import java.util.Map;

import static io.restassured.RestAssured.given;
import static org.hamcrest.Matchers.*;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@Tag("dev")
public class DeviceIT {

    @LocalServerPort
    private int port;

    @BeforeEach
    public void setup() {
        RestAssured.port = port;
    }

    @Test
    @DisplayName("设备应该能够发送激活/心跳请求")
    public void should_activate_device() {
        Map<String, Object> body = new HashMap<>();
        body.put("mac", "AA:BB:CC:DD:EE:FF");
        body.put("type", "ESP32-S3");

        given()
            .header("Device-Id", "AA:BB:CC:DD:EE:FF")
            .contentType(ContentType.JSON)
            .body(body)
        .when()
            .post("/api/device/activation")
        .then()
            .statusCode(anyOf(is(200), is(201), is(401)));
    }

    @Test
    @DisplayName("应该能够查询设备列表及其状态")
    public void should_list_devices() {
        given()
        .when()
            .get("/api/device")
        .then()
            .statusCode(anyOf(is(200), is(401)));
    }

    @Test
    @DisplayName("应该能够通过 ID 获取设备详细信息")
    public void should_get_device_info() {
        String deviceId = "AA:BB:CC:DD:EE:FF";
        given()
        .when()
            .get("/api/device/" + deviceId)
        .then()
            .statusCode(anyOf(is(200), is(401), is(404)));
    }
}
