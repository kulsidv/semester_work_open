package ru.kpfu.itis.kulsidv.controller;

import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import ru.kpfu.itis.kulsidv.dto.FormUserDto;
import ru.kpfu.itis.kulsidv.entity.User;
import ru.kpfu.itis.kulsidv.service.ChapterService;
import ru.kpfu.itis.kulsidv.service.UserService;

import java.security.Principal;
import java.util.Map;

@AllArgsConstructor
@Controller
public class UserController {
    private final UserService userService;
    private final ChapterService chapterService;

    @GetMapping(value = "/profile")
    String profile(Principal principal, Model model) {
        User user = userService.findProfileById(Integer.parseInt(principal.getName()));
        model.addAttribute("user", user);
        model.addAttribute("chapters", chapterService.findAll());
        return "profile";
    }

    @PostMapping(value = "/profile",
            consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Map<String, Object>> update(Principal principal,
                                                      @Valid @RequestBody FormUserDto userDto,
                                                      Model model) {
        try {
            FormUserDto user = userService.update(Integer.parseInt(principal.getName()), userDto, false);
            model.addAttribute("user", user);
            return ResponseEntity.ok().body(Map.of("redirect", "/profile"));
        } catch (DataIntegrityViolationException e) {
            return ResponseEntity.badRequest().body(Map.of("error","Ошибка обновления"));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("error",e.getMessage()));
        }
    }

    @DeleteMapping(value = "/profile/delete",
            produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Map<String, String>> delete(Principal principal){
        userService.delete(Integer.parseInt(principal.getName()));
        return ResponseEntity.ok().body(Map.of("redirect", "/"));
    }

}
