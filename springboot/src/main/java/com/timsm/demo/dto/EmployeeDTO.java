package com.timsm.demo.dto;

public class EmployeeDTO {
    private String empNo;
    private String korNm;

    public EmployeeDTO(String empNo, String korNm) {
        this.empNo = empNo;
        this.korNm = korNm;
    }

    public String getEmpNo() {
        return empNo;
    }

    public void setEmpNo(String empNo) {
        this.empNo = empNo;
    }

    public String getKorNm() {
        return korNm;
    }

    public void setKorNm(String korNm) {
        this.korNm = korNm;
    }
}
