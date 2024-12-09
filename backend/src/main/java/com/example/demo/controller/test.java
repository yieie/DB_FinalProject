package com.example.demo.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import java.util.HashMap;
import java.util.Map;

@RestController
public class test {
    @RequestMapping("/test")
    public String test() {
        
        return "Hello World";
    }

    @Autowired
    private NamedParameterJdbcTemplate test;

    @RequestMapping("/hello")
    public String hello() {
        
        String sql="create table spring_test (id int, name varchar(20))";
        Map<String, Object> map = new HashMap<>();
        test.update(sql, map);

        return "Hello World!";
    }
}