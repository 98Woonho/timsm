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
        // DB에서 유저 조회
        Map<String, Object> user = userMapper.findUserByIdAndPass(dto);

        // 유저 없음 → 로그인 실패
        if (user == null) {
            return LoginResponseDTO.builder()
                    .success(false)
                    .message("아이디나 비밀번호가 일치하지 않습니다.")
                    .build();
        }

        // 유저 있음 → 로그인 성공
        return LoginResponseDTO.builder()
                .success(true)
                .userId(String.valueOf(user.get("USER_ID")))
                .userName(String.valueOf(user.get("USER_NAME")))
                .message("로그인 성공")
                .build();
    }
}
