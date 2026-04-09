package com.timsm.demo.mapper;

import com.timsm.demo.dto.LoginRequestDTO;
import com.timsm.demo.dto.LoginResponseDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.Map;

@Mapper
public interface UserMapper {
    LoginResponseDTO findUserByIdAndPass(LoginRequestDTO dto);
}
