package com.timsm.demo.mapper;

import com.timsm.demo.dto.SalaryDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface SalaryMapper {
    List<SalaryDTO> findSalaryListByEmpNo(String empNo);
}
