package com.panda.controller;

import com.panda.service.SpiderService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Map;

@Controller
public class SpiderController {

    @Resource
    SpiderService spiderService;

    @RequestMapping("/startCrawl")
    public  @ResponseBody
    String startCrawl(@RequestParam Map<String, String> parameter, HttpServletRequest request, HttpServletResponse response, HttpSession session){
        
        return null;
    }
}
