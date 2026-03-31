# Java 项目测试用例模板

## 单元测试模板

### Service 层测试

```java
package com.xiaozhi.test.unit;

import com.xiaozhi.entity.User;
import com.xiaozhi.mapper.UserMapper;
import com.xiaozhi.service.UserService;
import com.xiaozhi.service.impl.UserServiceImpl;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.anyLong;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
@DisplayName("UserService 单元测试")
class UserServiceTest {

    @Mock
    private UserMapper userMapper;

    @InjectMocks
    private UserServiceImpl userService;

    private User testUser;

    @BeforeEach
    void setUp() {
        testUser = new User();
        testUser.setId(1L);
        testUser.setUsername("testuser");
        testUser.setEmail("test@example.com");
    }

    @Test
    @DisplayName("应该根据用户ID返回用户信息")
    void shouldReturnUserWhenValidIdProvided() {
        // Arrange
        Long userId = 1L;
        when(userMapper.selectById(userId)).thenReturn(testUser);

        // Act
        User result = userService.getUserById(userId);

        // Assert
        assertThat(result).isNotNull();
        assertThat(result.getId()).isEqualTo(userId);
        assertThat(result.getUsername()).isEqualTo("testuser");
    }

    @Test
    @DisplayName("应该在用户不存在时返回null")
    void shouldReturnNullWhenUserNotExists() {
        // Arrange
        Long userId = 999L;
        when(userMapper.selectById(anyLong())).thenReturn(null);

        // Act
        User result = userService.getUserById(userId);

        // Assert
        assertThat(result).isNull();
    }
}
```

### Controller 层测试

```java
package com.xiaozhi.test.unit;

import com.xiaozhi.controller.UserController;
import com.xiaozhi.service.UserService;
import com.xiaozhi.entity.User;
import com.xiaozhi.common.web.AjaxResult;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import static org.mockito.ArgumentMatchers.anyLong;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(UserController.class)
@DisplayName("UserController 单元测试")
class UserControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private UserService userService;

    private User testUser;

    @BeforeEach
    void setUp() {
        testUser = new User();
        testUser.setId(1L);
        testUser.setUsername("testuser");
        testUser.setEmail("test@example.com");
    }

    @Test
    @DisplayName("应该成功获取用户信息")
    void shouldGetUserSuccessfully() throws Exception {
        // Arrange
        when(userService.getUserById(1L)).thenReturn(testUser);

        // Act & Assert
        mockMvc.perform(get("/api/user/{id}", 1L)
                        .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.data.username").value("testuser"));
    }

    @Test
    @DisplayName("应该在用户不存在时返回错误")
    void shouldReturnErrorWhenUserNotExists() throws Exception {
        // Arrange
        when(userService.getUserById(anyLong())).thenReturn(null);

        // Act & Assert
        mockMvc.perform(get("/api/user/{id}", 999L)
                        .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(500));
    }
}
```

## 集成测试模板

```java
package com.xiaozhi.test.integration;

import com.xiaozhi.entity.User;
import com.xiaozhi.mapper.UserMapper;
import com.xiaozhi.service.UserService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.transaction.annotation.Transactional;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
@ActiveProfiles("test")
@Transactional
@DisplayName("用户服务集成测试")
class UserServiceIntegrationTest {

    @Autowired
    private UserService userService;

    @Autowired
    private UserMapper userMapper;

    private User testUser;

    @BeforeEach
    void setUp() {
        testUser = new User();
        testUser.setUsername("integrationtest");
        testUser.setEmail("integration@example.com");
        testUser.setPassword("password123");
    }

    @Test
    @DisplayName("应该成功创建并查询用户")
    void shouldCreateAndRetrieveUserSuccessfully() {
        // Arrange & Act
        userService.createUser(testUser);
        User retrievedUser = userService.getUserById(testUser.getId());

        // Assert
        assertThat(retrievedUser).isNotNull();
        assertThat(retrievedUser.getUsername()).isEqualTo("integrationtest");
        assertThat(retrievedUser.getEmail()).isEqualTo("integration@example.com");
    }

    @Test
    @DisplayName("应该成功更新用户信息")
    void shouldUpdateUserSuccessfully() {
        // Arrange
        userService.createUser(testUser);
        testUser.setEmail("updated@example.com");

        // Act
        userService.updateUser(testUser);
        User updatedUser = userService.getUserById(testUser.getId());

        // Assert
        assertThat(updatedUser.getEmail()).isEqualTo("updated@example.com");
    }
}
```

## 工具类测试模板

```java
package com.xiaozhi.test.unit;

import com.xiaozhi.utils.AudioUtils;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

@DisplayName("AudioUtils 工具类测试")
class AudioUtilsTest {

    @Test
    @DisplayName("应该正确计算音频时长")
    void shouldCalculateAudioDurationCorrectly() {
        // Arrange
        byte[] audioData = new byte[32000];
        int sampleRate = 16000;
        int bytesPerSample = 2;

        // Act
        double duration = AudioUtils.calculateDuration(audioData, sampleRate, bytesPerSample);

        // Assert
        assertThat(duration).isEqualTo(1.0);
    }

    @ParameterizedTest
    @ValueSource(ints = {8000, 16000, 44100})
    @DisplayName("应该支持不同的采样率")
    void shouldSupportDifferentSampleRates(int sampleRate) {
        // Arrange
        byte[] audioData = new byte[sampleRate * 2];

        // Act
        double duration = AudioUtils.calculateDuration(audioData, sampleRate, 2);

        // Assert
        assertThat(duration).isEqualTo(1.0);
    }

    @Test
    @DisplayName("应该在音频数据为空时抛出异常")
    void shouldThrowExceptionWhenAudioDataEmpty() {
        // Arrange
        byte[] emptyData = new byte[0];

        // Act & Assert
        assertThatThrownBy(() -> AudioUtils.calculateDuration(emptyData, 16000, 2))
                .isInstanceOf(IllegalArgumentException.class);
    }
}
```
