package com.timsm.demo.controller;

import com.timsm.demo.dto.LoginResponseDTO;
import com.timsm.demo.dto.LoginRequestDTO;
import com.timsm.demo.service.AuthService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.sql.SQLOutput;

@RestController
@RequestMapping("/api")
@RequiredArgsConstructor
public class AuthController {
    private final AuthService authService;

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody LoginRequestDTO loginRequestDTO) {
        LoginResponseDTO response = authService.login(loginRequestDTO);

        System.out.println(loginRequestDTO);

        if (!response.isSuccess()) {
            // 로그인 실패 시 401 반환 → Flutter에서 401로 감지
            return ResponseEntity.status(401).body(response);
        }

        return ResponseEntity.ok(response); // 200 반환
    }
}
