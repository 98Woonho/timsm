package com.timsm.demo.controller;

import com.timsm.demo.dto.EmployeeDTO;
import com.timsm.demo.mapper.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@CrossOrigin(origins = "*")
public class EmployeeController {
    @Autowired
    private EmployeeMapper employeeMapper;

    @GetMapping("/api/employee")
    public List<EmployeeDTO> getEmployeeList() {
        return employeeMapper.selectEmployeeList();
    }
}
