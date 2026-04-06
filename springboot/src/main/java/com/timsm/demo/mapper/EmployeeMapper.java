package com.timsm.demo.mapper;

import com.timsm.demo.dto.EmployeeDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface EmployeeMapper {
    List<EmployeeDTO> selectEmployeeList();
}