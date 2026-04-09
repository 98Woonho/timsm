package com.timsm.demo.service;

import com.timsm.demo.dto.SalaryDTO;
import com.timsm.demo.mapper.SalaryMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class SalaryService {
    private final SalaryMapper salaryMapper;

    public List<SalaryDTO> getSalaryList(String empNo) {
        return salaryMapper.findSalaryListByEmpNo(empNo);
    }
}