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
    private boolean success;
    private String userId;
    private String userName;
    private String message;
}
