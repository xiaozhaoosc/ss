package com.smallsteps.task.controller;

import com.kenzhao.smallsteps.task.controller.TaskChildController;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(TaskChildController.class)
public class TaskChildControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Test
    public void testGetPendingTasks_ReturnsList() throws Exception {
        mockMvc.perform(get("/child/task/pending?childId=123"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.length()").value(1))
                .andExpect(jsonPath("$[0].title").value("整理房间"));
    }
}
