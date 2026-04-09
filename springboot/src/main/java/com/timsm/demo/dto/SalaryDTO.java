package com.timsm.demo.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.math.BigDecimal;

@Getter
@Setter
@Builder
@ToString
public class SalaryDTO {
    private String payYm;
    private String empNo;
    private BigDecimal supply01;
}
