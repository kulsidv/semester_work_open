package ru.kpfu.itis.kulsidv.controller;

import lombok.AllArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import ru.kpfu.itis.kulsidv.dto.FrontUserDto;
import ru.kpfu.itis.kulsidv.entity.Chapter;
import ru.kpfu.itis.kulsidv.entity.User;
import ru.kpfu.itis.kulsidv.service.ChapterService;
import ru.kpfu.itis.kulsidv.service.ProgressService;
import ru.kpfu.itis.kulsidv.service.UserService;

import java.security.Principal;
import java.util.Map;

@AllArgsConstructor
@Controller
public class ChapterController {

    ChapterService chapterService;
    UserService userService;
    ProgressService progressService;


    @GetMapping("/chapter/{id}")
    public String index(Principal principal, Model model, @PathVariable Integer id) {
        Chapter chapter = chapterService.findById(id);
        FrontUserDto user = userService.findById(Integer.parseInt(principal.getName()));
        if (principal != null) {
            model.addAttribute("user", user);
        }
        if (id == 4 && progressService.containsFirst(user.getId())) {
            progressService.saveFirst(user.toUser());
        }
        model.addAttribute("chapter", chapter);
        model.addAttribute("chapters", chapterService.findAll());
        return "chapter";
    }

    @PostMapping(value = "/chapter/{id}", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Map<String, Integer>> set(@RequestBody Map<Integer, String> test, @PathVariable Integer id, Principal principal, Model model) {
        try {
            User user = userService.findByIdWithProgress(Integer.parseInt(principal.getName()));
            Integer result = progressService.save(test, id, user);
            model.addAttribute("user", user);
            return ResponseEntity.ok().body(Map.of("result", result));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
