package com.timsm.demo.controller;

import com.timsm.demo.dto.SalaryDTO;
import com.timsm.demo.service.SalaryService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;
import java.util.List;

@RestController
@RequestMapping("/api")
@RequiredArgsConstructor
public class SalaryController {
    private final SalaryService salaryService;

    @GetMapping("/salary")
    public ResponseEntity<?> getSalaryList(@RequestParam String empNo) {
        return ResponseEntity.ok(salaryService.getSalaryList(empNo));
    }
}
