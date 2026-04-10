package com.timsm.demo.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@Builder
@ToString
public class LoginResponseDTO {
    private String empNo;
    private String korNm;
    private String birthDt;
    private String enterDt;
    private String chikcNm;
    private String positionNm;
    private String hobCd;
    private String corpNm;
    private String deptNm;
}
