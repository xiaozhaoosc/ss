package com.smallsteps.task.controller;

import com.smallsteps.task.domain.dto.TaskCreateDTO;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/parent/task")
public class ParentTaskController {

    @PostMapping("/create")
    public ResponseEntity<String> createTask(@RequestBody TaskCreateDTO taskDto) {
        return ResponseEntity.ok("Success");
    }
}