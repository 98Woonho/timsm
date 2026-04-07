package com.timsm.demo.mapper;

import com.timsm.demo.dto.LoginRequestDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.Map;

@Mapper
public interface UserMapper {
    Map<String, Object> findUserByIdAndPass(LoginRequestDTO dto);
}
