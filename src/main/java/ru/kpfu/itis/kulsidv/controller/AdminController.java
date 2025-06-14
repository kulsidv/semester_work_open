package ru.kpfu.itis.kulsidv.controller;

import jakarta.validation.Valid;
import jakarta.validation.constraints.Min;
import lombok.AllArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import ru.kpfu.itis.kulsidv.dto.FormUserDto;
import ru.kpfu.itis.kulsidv.entity.Chapter;
import ru.kpfu.itis.kulsidv.entity.User;
import ru.kpfu.itis.kulsidv.service.AdminService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.ArrayList;
import java.util.Map;

@AllArgsConstructor
@Controller
@RequestMapping("/admin")
public class AdminController {

    private final AdminService adminService;

    @GetMapping(value = "")
    public String index() {
        return "admin/index";
    }

    @GetMapping(value = "/users", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Page<User>> users(@RequestParam(value = "page", defaultValue = "0") @Min(0) int page){
        return ResponseEntity.ok().body(adminService.findAllUsers(PageRequest.of(page, 10, Sort.by("id").descending())));
    }

    @GetMapping(value = "/users/{userId}", produces = MediaType.APPLICATION_JSON_VALUE)
    public String user(@PathVariable Integer userId, Model model){
        try {
            model.addAttribute("user",
                    adminService.findUserById(userId));
        } catch (Error e) {
            model.addAttribute("error", e.getMessage());
        }
        return "admin/user";
    }

    @GetMapping(value = "/users/create", produces = MediaType.APPLICATION_JSON_VALUE)
    public String createUser(Model model){
        model.addAttribute("path", "create");
        return "admin/user_form";
    }

    @PostMapping(value = "/users/create",
            produces = MediaType.APPLICATION_JSON_VALUE,
            consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Map<String, String>> createUser(@Valid @RequestBody FormUserDto user){
        try {
            User newUser = adminService.saveUser(user);
            return ResponseEntity.ok().body(Map.of("redirect", "/admin/users/" + newUser.getId()));
        } catch (Exception e){
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    @GetMapping(value = "/users/edit/{userId}", produces = MediaType.APPLICATION_JSON_VALUE)
    public String updateUser(@PathVariable Integer userId, Model model){
        model.addAttribute("path", "edit");
        model.addAttribute("user", adminService.findUserById(userId));
        return "admin/user_form";
    }

    @PostMapping(value = "/users/edit",
            produces = MediaType.APPLICATION_JSON_VALUE,
            consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Map<String, String>> updateUser(@RequestBody FormUserDto user){
        try {
            adminService.updateUser(user, true);
            return ResponseEntity.ok().body(Map.of("redirect", "/admin/users/" + user.getId()));
        } catch (Exception e){
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    @DeleteMapping(value = "/users/delete/{userId}",
            consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Map<String, String>> deleteUser(@PathVariable Integer userId){
        adminService.deleteUser(userId);
        return ResponseEntity.ok().body(Map.of("redirect", "/admin"));
    }

    @GetMapping(value = "/chapters",
            produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Page<Chapter>> chapters
            (@RequestParam(value = "page", defaultValue = "0") @Min(0) int page){
        Page<Chapter> resp = adminService.findAllChapters(PageRequest.of(page, 10, Sort.by("chapterNum").descending()));
        return ResponseEntity.ok().body(resp);
    }

    @GetMapping(value = "/chapters/{chapterId}", produces = MediaType.APPLICATION_JSON_VALUE)
    public String chapter(@PathVariable String chapterId, Model model){
        try {
            model.addAttribute("chapter",
                    adminService.findChapterById(Integer.parseInt(chapterId)));
        } catch (Error e) {
            model.addAttribute("error", e.getMessage());
        }
        return "admin/chapter";
    }

    @GetMapping(value = "/chapters/create", produces = MediaType.APPLICATION_JSON_VALUE)
    public String createChapter(Model model){
        model.addAttribute("path", "create");
        return "admin/chapter_form";
    }

    @PostMapping(value = "/chapters/create", consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Map<String, String>> createChapter(@Valid @RequestBody Chapter chapter){
        try {
            Chapter newChapter = adminService.saveChapter(chapter);
            return ResponseEntity.ok().body(Map.of("redirect", "/admin/chapters/" + newChapter.getId()));
        } catch (Exception e){
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    @GetMapping(value = "/chapters/edit/{chapterId}", produces = MediaType.APPLICATION_JSON_VALUE)
    public String updateChapter(@PathVariable Integer chapterId, Model model){
        model.addAttribute("path", "edit");
        model.addAttribute("chapter", adminService.findChapterById(chapterId));
        return "admin/chapter_form";
    }

    @PostMapping(value = "/chapters/edit",
            produces = MediaType.APPLICATION_JSON_VALUE,
            consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Map<String, String>> updateChapter(@Valid @RequestBody Chapter chapter){
        try {
            adminService.updateChapter(chapter);
            return ResponseEntity.ok().body(Map.of("redirect", "/admin/chapters/" + chapter.getId()));
        } catch (Exception e){
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    @DeleteMapping(value = "/chapters/delete/{chapterId}",
            consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Map<String, String>> deleteChapter(@PathVariable Integer chapterId){
        adminService.deleteChapter(chapterId);
        return ResponseEntity.ok().body(Map.of("redirect", "/admin"));
    }
}
