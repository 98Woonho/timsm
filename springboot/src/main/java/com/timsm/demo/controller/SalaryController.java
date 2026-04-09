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
        List<SalaryDTO> salaryList = salaryService.getSalaryList(empNo);

        if (salaryList.isEmpty()) {
            return ResponseEntity
                    .status(HttpStatus.NOT_FOUND)
                    .body(Collections.singletonMap("message", "급여내역이 존재하지 않습니다."));
        }

        return ResponseEntity.ok(salaryList);
    }
}
