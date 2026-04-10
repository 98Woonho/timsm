package com.timsm.demo.service;

import com.timsm.demo.dto.LoginRequestDTO;
import com.timsm.demo.dto.LoginResponseDTO;
import com.timsm.demo.exception.BusinessException;
import com.timsm.demo.mapper.UserMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
@RequiredArgsConstructor
public class AuthService {
    private final UserMapper userMapper;

    public LoginResponseDTO login(LoginRequestDTO dto) {
        LoginResponseDTO loginResponse = userMapper.findUserByIdAndPass(dto);

        if (loginResponse == null) {
            throw new BusinessException(HttpStatus.UNAUTHORIZED, "아이디나 비밀번호가 일치하지 않습니다.");
        }

        return loginResponse;
    }
}