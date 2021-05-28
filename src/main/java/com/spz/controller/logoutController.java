package com.spz.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
public class logoutController {
    @RequestMapping("/out")
    public String logout(HttpServletRequest request){
        request.getSession().invalidate();
        return "jsp/login";
    }
}
