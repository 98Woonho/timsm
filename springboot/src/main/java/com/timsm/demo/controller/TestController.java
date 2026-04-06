package com.timsm.demo.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestController {
    @GetMapping("/hello")
    public String hello() {
        return "백엔드 서버가 살아있습니다! 이제 DB 데이터를 가져올 차례에요.";
    }
}
