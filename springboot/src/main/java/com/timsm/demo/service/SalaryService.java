package com.timsm.demo.service;

import com.timsm.demo.dto.SalaryDTO;
import com.timsm.demo.exception.BusinessException;
import com.timsm.demo.mapper.SalaryMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class SalaryService {
    private final SalaryMapper salaryMapper;

    public List<SalaryDTO> getSalaryList(String empNo) {
        List<SalaryDTO> salaryList = salaryMapper.findSalaryListByEmpNo(empNo);

        if (salaryList.isEmpty()) {
            throw new BusinessException(HttpStatus.NOT_FOUND, "급여내역이 존재하지 않습니다.");
        }

        return salaryList;
    }
}