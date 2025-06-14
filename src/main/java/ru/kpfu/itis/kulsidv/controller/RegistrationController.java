package ru.kpfu.itis.kulsidv.controller;

import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import ru.kpfu.itis.kulsidv.dto.FormUserDto;
import ru.kpfu.itis.kulsidv.dto.VerifyDto;
import ru.kpfu.itis.kulsidv.entity.User;
import ru.kpfu.itis.kulsidv.service.UserService;

import java.util.Map;

@AllArgsConstructor
@Controller
@RequestMapping("/registration")
public class RegistrationController {

    UserService userService;

    @GetMapping("")
    public String getRegistration() {
        return "registration";
    }

    @PostMapping(value = "",
            consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Map<String, Object>> register(@Valid @RequestBody FormUserDto userDto){
        try {
            User user = userService.save(userDto);
            userService.sendVerificationCode(user.getId());
            return ResponseEntity.ok().body(Map.of("success", true, "userId", user.getId()));
        } catch (DataIntegrityViolationException e) {
            return ResponseEntity.badRequest().body(Map.of("error","Пользователь с таким именем уже существует!"));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("error",e.getMessage()));
        }
    }

    @PostMapping(value = "/verify",
            consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Map<String, Object>> verify(@RequestBody VerifyDto dto){
        try {
            if (userService.verify(dto)) {
                return ResponseEntity.ok().body(Map.of("success", true));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.badRequest().body(Map.of("message", "Ошибка верификации, попробуйте снова"));
    }

    @PostMapping(value = "/resend",
            consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Map<String, Object>> resendCode(@RequestBody VerifyDto dto){
        userService.sendVerificationCode(dto.userId());
        return ResponseEntity.ok().body(Map.of("success", true));
    }
}
