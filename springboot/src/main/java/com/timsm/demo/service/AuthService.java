package com.timsm.demo.service;

import com.timsm.demo.dto.LoginRequestDTO;
import com.timsm.demo.dto.LoginResponseDTO;
import com.timsm.demo.mapper.UserMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
@RequiredArgsConstructor
public class AuthService {
    private final UserMapper userMapper;

    public LoginResponseDTO login(LoginRequestDTO dto) {
        return userMapper.findUserByIdAndPass(dto);
    }
}