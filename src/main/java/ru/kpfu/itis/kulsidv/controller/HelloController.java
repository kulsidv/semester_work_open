package ru.kpfu.itis.kulsidv.controller;

import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import ru.kpfu.itis.kulsidv.dto.FrontUserDto;
import ru.kpfu.itis.kulsidv.service.ChapterService;
import ru.kpfu.itis.kulsidv.service.UserService;

import java.security.Principal;

@AllArgsConstructor
@Controller()
public class HelloController {

    UserService userService;
    ChapterService chapterService;

    @GetMapping("/")
    public String index(Principal principal, Model model) {
        if (principal != null) {
            FrontUserDto user = userService.findById(Integer.valueOf(principal.getName()));
            System.out.println(user.getUsername());
            model.addAttribute("user", user);
        }
        model.addAttribute("chapters", chapterService.findAll());
        return "index";
    }

}
