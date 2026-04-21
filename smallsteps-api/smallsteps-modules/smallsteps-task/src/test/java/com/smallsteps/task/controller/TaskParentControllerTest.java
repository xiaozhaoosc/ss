package com.smallsteps.task.controller;

import com.kenzhao.smallsteps.task.controller.TaskParentController;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(TaskParentController.class)
public class TaskParentControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Test
    public void testCreateTask_ReturnsOk() throws Exception {
        String jsonPayload = "{\"title\":\"完成数学作业\",\"rewardPoints\":50,\"childId\":123}";

        mockMvc.perform(post("/parent/task/create")
                .contentType(MediaType.APPLICATION_JSON)
                .content(jsonPayload))
                .andExpect(status().isOk());
    }
}
